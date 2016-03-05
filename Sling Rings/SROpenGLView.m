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
#import "SRShader.h"
#import "SRProgram.h"
#import "SRVertexBuffer.h"
#import "SRSprite.h"
#import "SRDefaultScene.h"

@interface SROpenGLView () {
    CAEAGLLayer* _eaglLayer;
    
    SRContext *_context;
    SRFrameBuffer *_frameBuffer;
    SRRenderBuffer *_renderBuffer;
    SRDefaultScene *_scene;
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
        //Setup OpenGL context
        _context = [[SRContext alloc] init];
        //Create RenderBuffer for displaying to the screen
        _renderBuffer = [[SRRenderBuffer alloc] init];
        _frameBuffer = [[SRFrameBuffer alloc] init];
        [_frameBuffer attachRenderBuffer:_renderBuffer];
        
        _scene = [[SRDefaultScene alloc] init];
        
        self.contentScaleFactor = [UIScreen mainScreen].scale;
    }
    return self;
}

+ (Class)layerClass {
    return [CAEAGLLayer class];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_context setRenderBufferStorage:_renderBuffer withLayer:_eaglLayer];
    [_renderBuffer bind];
    [_frameBuffer bind];
    _scene.size = self.frame.size;
    [self render];
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Methods
//////////////////////////////////////////////////////////////////////////

- (void)render {
    glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    float width = self.frame.size.width * self.contentScaleFactor;
    float height = self.frame.size.height * self.contentScaleFactor;
    glViewport(0.0, 0.0, width, height);
    [_scene draw];
    
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
