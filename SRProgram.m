//
//  SRProgram.m
//  Sling Rings
//

#import "SRProgram.h"
#import "SRShader.h"

@implementation SRProgram

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)initWithShaders:(NSArray *)shaders {
    self = [super init];
    if (self) {
        _value = glCreateProgram();
        _shaders = shaders;
        
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
    }
    return self;
}

- (void)dealloc {
    for (SRShader *shader in _shaders) {
        glDetachShader(_value, shader.value);
    }
}


@end
