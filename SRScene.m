//
//  SRScene.m
//  Sling Rings
//

#import "SRScene.h"
#import "SRShader.h"

@interface SRScene () {
    SRProgram *_program;
    
    SRAttribute *_positionSlot;
    SRAttribute *_sourceColorSlot;
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
        SRShader *vertexShader = [[SRShader alloc] initWithName:@"VertexShader" shaderType:SRShaderTypeVertex];
        SRShader *fragmentShader = [[SRShader alloc] initWithName:@"FragmentShader" shaderType:SRShaderTypeFragment];
        _program = [[SRProgram alloc] initWithShaders:@[vertexShader, fragmentShader]];
        
        _positionSlot = [[SRAttribute alloc] initWithName:@"Position" program:_program];
        _sourceColorSlot = [[SRAttribute alloc] initWithName:@"SourceColor" program:_program];
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
    SRSprite *sprite = [[SRSprite alloc] initWithPositionAttribute:_positionSlot colorAttribute:_sourceColorSlot modelMatrix:_modelMatrixSlot];
    [_sprites addObject:sprite];
    return sprite;
}

- (void)removeSprite:(SRSprite *)sprite {
    [_sprites removeObject:sprite];
}

- (void)draw {
    [_viewMatrixSlot setValue:self.transform];
    for (SRSprite *sprite in _sprites) {
        [sprite draw];
    }
}

@end
