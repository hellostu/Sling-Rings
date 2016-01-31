//
//  SRFrameBuffer.m
//  Sling Rings
//
//  Created by Stuart Lynch on 29/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRFrameBuffer.h"

@interface SRFrameBuffer ()
@end

@implementation SRFrameBuffer

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)init {
    self = [super init];
    if (self) {
        glGenFramebuffers(1, &_value);
        [self bind];
    }
    return self;
}

- (void)dealloc {
    glDeleteFramebuffers(1, &_value);
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Methods
//////////////////////////////////////////////////////////////////////////

- (void)bind {
    glBindFramebuffer(GL_FRAMEBUFFER, _value);
}

- (void)attachRenderBuffer:(SRRenderBuffer *)renderBuffer {
    [self bind];
    [renderBuffer bind];
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, renderBuffer.value);
    
}

- (void)checkStatus {
    [self bind];
    GLenum status = glCheckFramebufferStatus(GL_FRAMEBUFFER);
    
    switch (status) {
        case GL_FRAMEBUFFER_COMPLETE:
            NSLog(@"FRAMEBUFFER COMPLETE");
            break;
        case GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT:
            NSLog(@"FRAMEBUFFER INCOMPLETE ATTACHMENT");
            break;
        case GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT:
            NSLog(@"FRAMEBUFFER INCOMPLETE MISSING ATTACHMENT");
            break;
        case GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS:
            NSLog(@"FRAMEBUFFER INCOMPLETE DIMENSIONS");
            break;
        case GL_FRAMEBUFFER_UNSUPPORTED:
            NSLog(@"FRAMEBUFFER UNSUPPORTED");
            break;
        default:
            break;
    }
}

@end
