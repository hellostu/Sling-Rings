//
//  SRProgram.h
//  Sling Rings
//
//  This objects wraps a glProgram. It references the shaders used to
//  make the program.
//

#ifndef SRProgram_h
#define SRProgram_h

#import <Foundation/Foundation.h>
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

@interface SRProgram : NSObject

@property(assign, readonly) GLuint value;
@property(readonly, nonatomic) NSArray *shaders;
- (id)initWithShaders:(NSArray *)shaders;
@end

#endif