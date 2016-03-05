//
//  SRSprite.m
//  Sling Rings
//

#import "SRSprite.h"
#import "SRVertexBuffer.h"

@interface SRSprite () {
    SRVertexBuffer          *_vertexBuffer;
    __weak SRUniform        *_modelMatrixSlot;
}
@end

@implementation SRSprite

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)initWithPositionAttribute:(SRAttribute *)positionAttribute colorAttribute:(SRAttribute *)colorAttribute textureAttribute:(SRAttribute *)textureAttribute modelMatrix:(SRUniform *)modelMatrix {
    self = [super init];
    if (self) {
        SRVertices *vertices = [[SRVertices alloc] initWithSize:4 positionAttribute:positionAttribute colorAttribute:colorAttribute textureAttribute:textureAttribute];
        SRTriangles *triangles = [[SRTriangles alloc] initWithSize:2];
        [vertices setVertex:SRVertexMake(SRPointMake( 1, -1, -7), SRColorMake(1, 0, 0, 1), SRTexCoordMake(1, 0)) atIndex:0];
        [vertices setVertex:SRVertexMake(SRPointMake( 1,  1, -7), SRColorMake(0, 1, 0, 1), SRTexCoordMake(1, 1)) atIndex:1];
        [vertices setVertex:SRVertexMake(SRPointMake(-1,  1, -7), SRColorMake(0, 0, 1, 1), SRTexCoordMake(0, 1)) atIndex:2];
        [vertices setVertex:SRVertexMake(SRPointMake(-1, -1, -7), SRColorMake(0, 0, 0, 1), SRTexCoordMake(0, 0)) atIndex:3];
        [triangles setTriangle:SRTriangleMake(0, 1, 2) atIndex:0];
        [triangles setTriangle:SRTriangleMake(2, 3, 0) atIndex:1];
        
        _vertexBuffer = [[SRVertexBuffer alloc] initWithVertices:vertices triangles:triangles];
        [_vertexBuffer submit];
        
        _modelMatrixSlot = modelMatrix;
    }
    return self;
}

- (void)draw {
    if (_texture != nil) {
        [_texture bind];
    }
    [_modelMatrixSlot setMatrix:self.transform];
    [_vertexBuffer draw];
}

@end
