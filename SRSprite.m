//
//  SRSprite.m
//  Sling Rings
//
//  Created by Stuart Lynch on 31/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRSprite.h"
#import "SRVertexBuffer.h"

@interface SRSprite () {
    SRVertexBuffer *_vertexBuffer;
}
@end

@implementation SRSprite

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)initWithProgram:(SRProgram *)program {
    self = [super init];
    if (self) {
        _vertexBuffer = [[SRVertexBuffer alloc] initWithNumberOfVertices:4 numberOfTriangles:2 program:program];
        
        [_vertexBuffer.vertices setVertex:SRVertexMake(SRPointMake( 1, 0, 0), SRColorMake(1, 0, 0, 1)) atIndex:0];
        [_vertexBuffer.vertices setVertex:SRVertexMake(SRPointMake( 1,  1, 0), SRColorMake(0, 1, 0, 1)) atIndex:1];
        [_vertexBuffer.vertices setVertex:SRVertexMake(SRPointMake(0,  1, 0), SRColorMake(0, 0, 1, 1)) atIndex:2];
        [_vertexBuffer.vertices setVertex:SRVertexMake(SRPointMake(0, 0, 0), SRColorMake(0, 0, 0, 1)) atIndex:3];
        [_vertexBuffer.triangles setTriangle:SRTriangleMake(0, 1, 2) atIndex:0];
        [_vertexBuffer.triangles setTriangle:SRTriangleMake(2, 3, 0) atIndex:1];
        
        [_vertexBuffer submit];
    }
    return self;
}

- (void)draw {
    [_vertexBuffer draw];
}

@end
