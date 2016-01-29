//
//  SRContext.m
//  Sling Rings
//
//  Created by Stuart Lynch on 29/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRContext.h"
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

@interface SRContext () {
    EAGLContext *_context;
    SRRenderBuffer *_renderBuffer;
}
@end

@implementation SRContext

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)init {
    self = [super init];
    if (self) {
        _context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        if (!_context) {
            NSLog(@"Failed to initialize OpenGLES 2.0 context");
            exit(1);
        }
        
        if (![EAGLContext setCurrentContext:_context]) {
            NSLog(@"Failed to set current OpenGL context");
            exit(1);
        }
    }
    return self;
}

- (void)setRenderBufferStorage:(SRRenderBuffer *)renderBuffer withLayer:(CAEAGLLayer *)layer {
    _renderBuffer = renderBuffer;
    [renderBuffer bind];
    [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:layer];
}

- (void)display {
    [_renderBuffer bind];
    [_context presentRenderbuffer:GL_RENDERBUFFER];
}

@end
