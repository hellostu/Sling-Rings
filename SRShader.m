//
//  SRShader.m
//  Sling Rings
//
//  Created by Stuart Lynch on 29/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRShader.h"

@implementation SRShader

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)initWithName:(NSString *)name shaderType:(SRShaderType)shaderType {
    self = [super init];
    if (self) {
        _shaderType = shaderType;
        NSString* shaderPath = [[NSBundle mainBundle] pathForResource:name
                                                               ofType:@"glsl"];
        NSError* error;
        NSString* shaderString = [NSString stringWithContentsOfFile:shaderPath
                                                           encoding:NSUTF8StringEncoding error:&error];
        if (!shaderString) {
            NSLog(@"Error loading shader: %@", error.localizedDescription);
            exit(1);
        }
        
        GLenum glShaderType;
        switch (shaderType) {
            case SRShaderTypeFragment:
                glShaderType = GL_FRAGMENT_SHADER;
                break;
            case SRShaderTypeVertex:
                glShaderType = GL_VERTEX_SHADER;
                break;
        }   
        
        _value = glCreateShader(glShaderType);
        
        const char * shaderStringUTF8 = [shaderString UTF8String];
        int shaderStringLength = (int)[shaderString length];
        glShaderSource(_value, 1, &shaderStringUTF8, &shaderStringLength);
        
        glCompileShader(_value);
        
        GLint compileSuccess;
        glGetShaderiv(_value, GL_COMPILE_STATUS, &compileSuccess);
        if (compileSuccess == GL_FALSE) {
            GLchar messages[256];
            glGetShaderInfoLog(_value, sizeof(messages), 0, &messages[0]);
            NSString *messageString = [NSString stringWithUTF8String:messages];
            NSLog(@"%@", messageString);
            exit(1);
        }
    }
    return self;
}

- (void)dealloc {
    glDeleteShader(_value);
}


@end
