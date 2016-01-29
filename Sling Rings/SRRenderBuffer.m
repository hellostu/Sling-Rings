//
//  SRRenderBuffer.m
//  Sling Rings
//
//  Created by Stuart Lynch on 29/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRRenderBuffer.h"
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

@interface SRRenderBuffer () {
}
@end

@implementation SRRenderBuffer

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)initWithFrameBuffer:(SRFrameBuffer *)frameBuffer {
    self = [super init];
    if (self) {
        glGenRenderbuffers(1, &_value);
        _frameBuffer = frameBuffer;
        [_frameBuffer bind];
        [self bind];
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0,
                                  GL_RENDERBUFFER, _value);
    }
    return self;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Methods
//////////////////////////////////////////////////////////////////////////

- (void)bind {
    glBindRenderbuffer(GL_RENDERBUFFER, _value);
}

@end
