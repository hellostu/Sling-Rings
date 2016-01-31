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

@interface SROpenGLView () {
    CAEAGLLayer* _eaglLayer;
    
    SRContext *_context;
    SRFrameBuffer *_frameBuffer;
    SRRenderBuffer *_renderBuffer;
    SRProgram *_program;
    SRVertexBuffer *_vertexBuffer;
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
        _renderBuffer = [[SRRenderBuffer alloc] init];
        _frameBuffer = [[SRFrameBuffer alloc] init];
        [_frameBuffer attachRenderBuffer:_renderBuffer];
        
        SRShader *vertexShader = [[SRShader alloc] initWithName:@"VertexShader" shaderType:SRShaderTypeVertex];
        SRShader *fragmentShader = [[SRShader alloc] initWithName:@"FragmentShader" shaderType:SRShaderTypeFragment];
        _program = [[SRProgram alloc] initWithShaders:@[vertexShader, fragmentShader]];
        
        _vertexBuffer = [[SRVertexBuffer alloc] initWithNumberOfVertices:4 numberOfTriangles:2 program:_program];
        [_vertexBuffer.vertices setVertex:SRVertexMake(SRPointMake( 1, -1, 0), SRColorMake(1, 0, 0, 1)) atIndex:0];
        [_vertexBuffer.vertices setVertex:SRVertexMake(SRPointMake( 1,  1, 0), SRColorMake(0, 1, 0, 1)) atIndex:1];
        [_vertexBuffer.vertices setVertex:SRVertexMake(SRPointMake(-1,  1, 0), SRColorMake(0, 0, 1, 1)) atIndex:2];
        [_vertexBuffer.vertices setVertex:SRVertexMake(SRPointMake(-1, -1, 0), SRColorMake(0, 0, 0, 1)) atIndex:3];
        [_vertexBuffer.triangles setTriangle:SRTriangleMake(0, 1, 2) atIndex:0];
        [_vertexBuffer.triangles setTriangle:SRTriangleMake(2, 3, 0) atIndex:1];
        [_vertexBuffer submit];
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
    
    [self render];
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Methods
//////////////////////////////////////////////////////////////////////////

- (void)render {
    glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    glViewport(0, 0, self.frame.size.width, self.frame.size.height);
    [_vertexBuffer draw];
    
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
