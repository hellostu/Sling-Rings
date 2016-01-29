//
//  SRRenderBuffer.h
//  Sling Rings
//
//  Created by Stuart Lynch on 29/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

#import "SRFrameBuffer.h"

@interface SRRenderBuffer : NSObject

@property(assign, readwrite) GLuint value;
@property(strong, readonly) SRFrameBuffer *frameBuffer;

- (id)initWithFrameBuffer:(SRFrameBuffer *)frameBuffer;
- (void)bind;

@end
