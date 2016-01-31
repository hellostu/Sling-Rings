//
//  SRFrameBuffer.h
//  Sling Rings
//
//  Created by Stuart Lynch on 29/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#ifndef SRFrameBuffer_h
#define SRFrameBuffer_h

#import <Foundation/Foundation.h>
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>
#import "SRRenderBuffer.h"
@class SRRenderBuffer;

@interface SRFrameBuffer : NSObject

@property(assign, readwrite) GLuint value;

- (void)bind;
- (void)attachRenderBuffer:(SRRenderBuffer *)renderBuffer;
- (void)checkStatus;

@end

#endif
