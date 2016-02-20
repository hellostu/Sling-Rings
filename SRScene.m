//
//  SRScene.m
//  Sling Rings
//
//  Created by Stuart Lynch on 20/02/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRScene.h"
#import "SRShader.h"

@interface SRScene () {
    SRShader *_fragmentShader;
    SRShader *_vertexShader;
    SRProgram *_program;
    
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
        _vertexShader = [[SRShader alloc] initWithName:@"VertexShader" shaderType:SRShaderTypeVertex];
        _fragmentShader = [[SRShader alloc] initWithName:@"FragmentShader" shaderType:SRShaderTypeFragment];
        _program = [[SRProgram alloc] initWithShaders:@[_vertexShader, _fragmentShader]];
        
        _position = [[SRAttribute alloc] initWithName:@"Position" program:_program];
        _sourceColor = [[SRAttribute alloc] initWithName:@"SourceColor" program:_program];
        _viewMatrix = [[SRUniform alloc] initWithName:@"View" program:_program];
        
        _sprites = [[NSMutableArray alloc] init];
    }
    return self;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Methods
//////////////////////////////////////////////////////////////////////////

- (SRSprite *)generateNewSprite {
    SRSprite *sprite = [[SRSprite alloc] initWithProgram:_program];
    [_sprites addObject:sprite];
    return sprite;
}

- (void)removeSprite:(SRSprite *)sprite {
    [_sprites removeObject:sprite];
}

- (void)draw {
    for (SRSprite *sprite in _sprites) {
        [sprite draw];
    }
}

@end
