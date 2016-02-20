//
//  SRProgram.m
//  Sling Rings
//
//  Created by Stuart Lynch on 29/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRProgram.h"
#import "SRShader.h"

@interface SRProgram () {
    NSMutableArray *_attributes;
    SRUniform *_viewUniform;
}
@end

@implementation SRProgram
@dynamic colorAttribute;
@dynamic positionAttribute;

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)initWithShaders:(NSArray *)shaders {
    self = [super init];
    if (self) {
        _value = glCreateProgram();
        _shaders = shaders;
        _attributes = [[NSMutableArray alloc] init];
        
        for (SRShader *shader in shaders) {
            glAttachShader(_value, shader.value);
        }
        glLinkProgram(_value);
        
        GLint linkSuccess;
        glGetProgramiv(_value, GL_LINK_STATUS, &linkSuccess);
        if (linkSuccess == GL_FALSE) {
            GLchar messages[256];
            glGetProgramInfoLog(_value, sizeof(messages), 0, &messages[0]);
            NSString *messageString = [NSString stringWithUTF8String:messages];
            NSLog(@"%@", messageString);
            exit(1);
        }
        glUseProgram(_value);
        
        [self declareAttributeWithName:@"Position" isVertexAttribute:YES];
        [self declareAttributeWithName:@"SourceColor" isVertexAttribute:YES];
        
        _viewUniform = [[SRUniform alloc] initWithName:@"View" program:self];
        
    }
    return self;
}

- (void)dealloc {
    for (SRShader *shader in _shaders) {
        glDetachShader(_value, shader.value);
    }
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Methods
//////////////////////////////////////////////////////////////////////////

- (SRAttribute *)positionAttribute {
    return _attributes[0];
}

- (SRAttribute *)colorAttribute {
    return _attributes[1];
}

- (SRUniform *)viewUniform {
    return _viewUniform;
}

- (void)declareAttributeWithName:(NSString *)name isVertexAttribute:(BOOL)vertexAttribute {
    SRAttribute *attribute = [[SRAttribute alloc] initWithName:name program:self];
    attribute.vertexAttribute = vertexAttribute;
    [_attributes addObject:attribute];
}


@end
