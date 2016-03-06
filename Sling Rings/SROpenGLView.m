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
        
        _scene = [[SRDefaultScene alloc] init];
        _scene.contentScaleFactor = [UIScreen mainScreen].scale;
        
        self.contentScaleFactor = [UIScreen mainScreen].scale;
    }
    return self;
}

+ (Class)layerClass {
    return [CAEAGLLayer class];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_scene setRenderBufferLayer:_eaglLayer];
    _scene.size = self.frame.size;
    [self render];
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Methods
//////////////////////////////////////////////////////////////////////////

- (void)render {
    [_scene draw];
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private Methods
//////////////////////////////////////////////////////////////////////////

- (void)__setupLayer {
    _eaglLayer = (CAEAGLLayer*) self.layer;
    _eaglLayer.opaque = YES;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Touches
//////////////////////////////////////////////////////////////////////////

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    SRPoint point = [self pointFromTouches:touches];
    [_scene touchBeganAtPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    SRPoint point = [self pointFromTouches:touches];
    [_scene touchMovedToPoint:point];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    SRPoint point = [self pointFromTouches:touches];
    [_scene touchEndedAtPoint:point];
}

- (SRPoint)pointFromTouches:(NSSet<UITouch *> *)touches {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    return SRPointMake(location.x, location.y, 0.0);
}

@end
