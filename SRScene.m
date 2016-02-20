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
    SRUniform *_viewMatrixSlot;
    SRUniform *_modelMatrixSlot;
    
    NSMutableArray *_sprites;
}
@end

@implementation SRScene

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
        _viewMatrixSlot = [[SRUniform alloc] initWithName:@"View" program:_program];
        _modelMatrixSlot = [[SRUniform alloc] initWithName:@"Model" program:_program];
        
        _sprites = [[NSMutableArray alloc] init];
    }
    return self;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Methods
//////////////////////////////////////////////////////////////////////////

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

@end
