//
//  SRScene.m
//  Sling Rings
//

#import "SRScene.h"
#import "SRShader.h"

@interface SRScene () {
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

- (SRSprite *)generateNewSprite {
    SRSprite *sprite = [[SRSprite alloc] initWithPositionAttribute:_positionSlot colorAttribute:_sourceColorSlot textureAttribute:_textureSlot modelMatrix:_modelMatrixSlot];
    [_sprites addObject:sprite];
    return sprite;
}

- (void)removeSprite:(SRSprite *)sprite {
    [_sprites removeObject:sprite];
}

- (void)draw {
    [_viewMatrixSlot setMatrix:self.transform];
    for (SRSprite *sprite in _sprites) {
        [sprite draw];
    }
}

- (void)printSpriteScreenLoc:(SRSprite *)sprite {
    GLfloat points[] = {1,1,-1,1,1,-1,-1,-1};
    
    printf("width: %.1f, height: %.1f\n", _size.width, _size.height);
    for(int i = 0; i<4; i++) {
        SRMatrix *vec = [[SRMatrix alloc] initWithWidth:1 height:4];
        [vec setValue:points[i*2] atI:0 J:0];
        [vec setValue:points[i*2+1] atI:0 J:1];
        [vec setValue:0 atI:0 J:2];
        [vec setValue: 1 atI:0 J:3];
        
        SRMatrix *loc = [[vec transpose] multiply:sprite.transform];
        SRPoint worldPoint = SRPointMake(loc.raw[0], loc.raw[1], 0.0);
        SRPoint screenPoint = [self screenPointFromWorldPoint:worldPoint];
        printf("%.1f, %.1f\n", screenPoint.x, screenPoint.y);
    }
    
}


@end
