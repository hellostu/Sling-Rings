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
    SRAttribute    *_positionAttribute;
    SRAttribute    *_colorAttribute;
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
        _positionAttribute = [[SRAttribute alloc] initWithName:@"Position" program:program];
        _colorAttribute = [[SRAttribute alloc] initWithName:@"SourceColor" program:program];
        
        SRVertices *vertices = [[SRVertices alloc] initWithSize:4 positionAttribute:_positionAttribute colorAttribute:_colorAttribute];
        SRTriangles *triangles = [[SRTriangles alloc] initWithSize:2];
        [vertices setVertex:SRVertexMake(SRPointMake( 1, 0, 0), SRColorMake(1, 0, 0, 1)) atIndex:0];
        [vertices setVertex:SRVertexMake(SRPointMake( 1,  1, 0), SRColorMake(0, 1, 0, 1)) atIndex:1];
        [vertices setVertex:SRVertexMake(SRPointMake(0,  1, 0), SRColorMake(0, 0, 1, 1)) atIndex:2];
        [vertices setVertex:SRVertexMake(SRPointMake(0, 0, 0), SRColorMake(0, 0, 0, 1)) atIndex:3];
        [triangles setTriangle:SRTriangleMake(0, 1, 2) atIndex:0];
        [triangles setTriangle:SRTriangleMake(2, 3, 0) atIndex:1];
        
        _vertexBuffer = [[SRVertexBuffer alloc] initWithVertices:vertices triangles:triangles];
        [_vertexBuffer submit];
    }
    return self;
}

- (void)draw {
    [_vertexBuffer draw];
}

@end
