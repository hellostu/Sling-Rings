//
//  SRScene.m
//  Sling Rings
//

#import "SRScene.h"
#import "SRShader.h"
#import "SRFrameBuffer.h"
#import "SRContext.h"
#import "SRRenderBuffer.h"

@interface SRScene () {
    
    SRContext *_context;
    SRFrameBuffer *_frameBuffer;
    SRRenderBuffer *_renderBuffer;
    
    SRProgram *_program;
    
    //Slots
    SRAttribute *_positionSlot;
    SRAttribute *_sourceColorSlot;
    SRAttribute *_textureSlot;
    
    SRUniform *_projectionMatrixSlot;
    SRUniform *_viewMatrixSlot;
    SRUniform *_modelMatrixSlot;
    
    NSMutableArray *_sprites;
    
    SRMatrix *_projectionMatrix;
    
    CGSize _size;
}
@end

@implementation SRScene
@dynamic size;

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (instancetype)init
{
    self = [super init];
    if (self) {
        _contentScaleFactor = 1;
        
        //Setup OpenGL context
        _context = [[SRContext alloc] init];
        //Create RenderBuffer for displaying to the screen
        _renderBuffer = [[SRRenderBuffer alloc] init];
        _frameBuffer = [[SRFrameBuffer alloc] init];
        [_frameBuffer attachRenderBuffer:_renderBuffer];
        
        //Create underlying program by compiling Vertex & Fragment shaders.
        //This complexity will be hidden from all objects at a higher level.
        SRShader *vertexShader = [[SRShader alloc] initWithName:@"VertexShader" shaderType:SRShaderTypeVertex];
        SRShader *fragmentShader = [[SRShader alloc] initWithName:@"FragmentShader" shaderType:SRShaderTypeFragment];
        _program = [[SRProgram alloc] initWithShaders:@[vertexShader, fragmentShader]];
        
        //Reference all of the "Slots". This is so we can bridge data over to GLSL world. 
        _positionSlot = [[SRAttribute alloc] initWithName:@"Position" program:_program];
        _sourceColorSlot = [[SRAttribute alloc] initWithName:@"SourceColor" program:_program];
        _textureSlot = [[SRAttribute alloc] initWithName:@"TexCoordIn" program:_program];
        
        _projectionMatrixSlot = [[SRUniform alloc] initWithName:@"Projection" program:_program];
        _viewMatrixSlot = [[SRUniform alloc] initWithName:@"View" program:_program];
        _modelMatrixSlot = [[SRUniform alloc] initWithName:@"Model" program:_program];
        
        _projectionMatrix = [SRMatrix identity];
        
        _sprites = [[NSMutableArray alloc] init];
    }
    return self;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Methods
//////////////////////////////////////////////////////////////////////////

- (void)setRenderBufferLayer:(CAEAGLLayer *)layer {
    [_context setRenderBufferStorage:_renderBuffer withLayer:layer];
}

//This maths will only work for 2D games, does not
//translate to 3D.
- (SRPoint)screenPointFromWorldPoint:(SRPoint)point {
    GLfloat x = (point.x + 1.0) / 2;
    GLfloat y = (point.y + 1.0) / 2;
    
    if(_size.width < _size.height) {
        x = x * _size.width;
        y = y * _size.width + (_size.height - _size.width)/2;
    } else {
        x = x * _size.height + (_size.width - _size.height)/2;
        y = y * _size.height;
    }
    
    y = -y + _size.height;
    
    return SRPointMake(x, y, 0);
}

//This maths will only work for 2D games, does not
//translate to 3D.
- (SRPoint)worldPointFromScreenPoint:(SRPoint)point {
    CGFloat x = point.x;
    CGFloat y = point.y;
    
    y = -y + _size.height;
    
    if(_size.width < _size.height) {
        x = x / _size.width;
        y = (y - (_size.height - _size.width)/2) / _size.width;
    } else {
        x = (x - (_size.width - _size.height)/2) / _size.height;
        y = y / _size.height;
    }
    
    x = x*2 - 1.0;
    y = y*2 - 1.0;
    
    return SRPointMake(x, y, 0);
}

- (void)setSize:(CGSize)size {
    _size = size;
    
    float hori;
    float vert;
    if (size.height < size.width) {
        hori = 1;
        vert = size.height / size.width;
    } else {
        hori = size.width / size.height;
        vert = 1;
    }
    
    _projectionMatrix = [SRMatrix populateProjectionFromFrustumLeft:-hori
                                                           andRight: hori
                                                          andBottom:-vert
                                                             andTop: vert
                                                            andNear:4
                                                             andFar:10];
    [_projectionMatrixSlot setMatrix:_projectionMatrix];
    
    for (SRSprite *sprite in _sprites) {
        [self printSpriteScreenLoc:sprite];
        printf("\n");
    }
}

- (CGSize)size {
    return _size;
}

- (SRSprite *)generateNewSpriteWithClass:(Class)spriteClass {
    if([spriteClass isSubclassOfClass:SRSprite.class] == false) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Class must be subclass of SRSprite" userInfo:nil];
    }
    
    SRSprite *sprite = [[spriteClass alloc] initWithScene:self
                                     positionAttribute:_positionSlot
                                        colorAttribute:_sourceColorSlot
                                      textureAttribute:_textureSlot
                                           modelMatrix:_modelMatrixSlot];
    [_sprites addObject:sprite];
    return sprite;
}

- (void)removeSprite:(SRSprite *)sprite {
    [_sprites removeObject:sprite];
}

- (void)draw {
    glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    float width = _size.width * self.contentScaleFactor;
    float height = _size.height * self.contentScaleFactor;
    glViewport(0.0, 0.0, width, height);
    
    [_renderBuffer bind];
    [_frameBuffer bind];
    [_viewMatrixSlot setMatrix:self.transform];
    for (SRSprite *sprite in _sprites) {
        [sprite draw];
    }
    [_context display];
}

- (void)printSpriteScreenLoc:(SRSprite *)sprite {
    GLfloat points[] = {1,1,-1,1,1,-1,-1,-1};
    
    printf("width: %.1f, height: %.1f\n", _size.width, _size.height);
    for(int i = 0; i<4; i++) {
        SRMatrix *vec = [[SRMatrix alloc] initWithHeight:4 width:1];
        [vec setValue:points[i*2]   atI:0 J:0];
        [vec setValue:points[i*2+1] atI:1 J:0];
        [vec setValue:0             atI:2 J:0];
        [vec setValue:1             atI:3 J:0];
        
        SRMatrix *loc = [sprite.transform multiply:vec];
        SRPoint worldPoint = SRPointMake(loc.raw[0], loc.raw[1], 0.0);
        SRPoint screenPoint = [self screenPointFromWorldPoint:worldPoint];
        printf("%.1f, %.1f\n", screenPoint.x, screenPoint.y);
    }
    
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Touches
//////////////////////////////////////////////////////////////////////////

- (void)touchBeganAtPoint:(SRPoint)point {
    SRPoint world = [self worldPointFromScreenPoint:point];
    printf("%.2f, %.2f\n", world.x, world.y);
}

- (void)touchMovedToPoint:(SRPoint)point {
    SRPoint world = [self worldPointFromScreenPoint:point];
    printf("%.2f, %.2f\n", world.x, world.y);
}

- (void)touchEndedAtPoint:(SRPoint)point {
    SRPoint world = [self worldPointFromScreenPoint:point];
    printf("%.2f, %.2f\n", world.x, world.y);
}

@end
