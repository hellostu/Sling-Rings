//
//  OpenGLView.m
//  Sling Rings
//
//  Created by Stuart Lynch on 29/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SROpenGLView.h"
#import <QuartzCore/QuartzCore.h>
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

#import "SRContext.h"
#import "SRFrameBuffer.h"
#import "SRRenderBuffer.h"

@interface SROpenGLView () {
    CAEAGLLayer* _eaglLayer;
    
    SRContext *_context;
    SRFrameBuffer *_frameBuffer;
    SRRenderBuffer *_renderBuffer;
}
@end

@implementation SROpenGLView

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self __setupLayer];
        _context = [[SRContext alloc] init];
        _frameBuffer = [[SRFrameBuffer alloc] init];
        _renderBuffer = [[SRRenderBuffer alloc] initWithFrameBuffer:_frameBuffer];
    }
    return self;
}

+ (Class)layerClass {
    return [CAEAGLLayer class];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self initRenderBufferStorage];
    [self render];
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Methods
//////////////////////////////////////////////////////////////////////////

- (void)initRenderBufferStorage {
    [_context setRenderBufferStorage:_renderBuffer withLayer:_eaglLayer];
}

- (void)render {
    glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    [_context display];
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private Methods
//////////////////////////////////////////////////////////////////////////

- (void)__setupLayer {
    _eaglLayer = (CAEAGLLayer*) self.layer;
    _eaglLayer.opaque = YES;
}

@end
