//
//  SRShader.h
//  Sling Rings
//
//  An object used to compile and reference a GLSL shader.
//

#ifndef SRShader_h
#define SRShader_h

#import <Foundation/Foundation.h>
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

typedef enum {
    SRShaderTypeVertex,
    SRShaderTypeFragment
} SRShaderType;

@interface SRShader : NSObject

@property(assign, readonly) GLuint value;
@property(assign, readonly) SRShaderType shaderType;

- (id)initWithName:(NSString *)name shaderType:(SRShaderType)shaderType;

@end

#endif