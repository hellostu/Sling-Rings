//
//  SRSprite.m
//  Sling Rings
//

#import "SRSprite.h"
#import "SRVertexBuffer.h"

@interface SRSprite () {
    SRVertexBuffer          *_vertexBuffer;
    __weak SRUniform        *_modelMatrixSlot;
    __weak SRScene          *_scene;
}
@end

@implementation SRSprite
@dynamic boundingBox;

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)initWithScene:(SRScene *)scene
  positionAttribute:(SRAttribute *)positionAttribute
     colorAttribute:(SRAttribute *)colorAttribute
   textureAttribute:(SRAttribute *)textureAttribute
        modelMatrix:(SRUniform *)modelMatrix {
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

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Methods
//////////////////////////////////////////////////////////////////////////

- (SRRect)boundingBox {
    
    GLfloat minX =  100000000000;
    GLfloat maxX = -100000000000;
    GLfloat minY =  100000000000;
    GLfloat maxY = -100000000000;
    
    for (int i=0; i<4; i++) {
        SRPoint point = (*[_vertexBuffer.vertices vertexAtIndex:i]).point;
        SRMatrix *vector = [SRMatrix vectorFromPoint:point];
        SRMatrix *actual = [self.transform multiply:vector];
        
        if (actual.raw[0] < minX) {
            minX = actual.raw[0];
        } else if(actual.raw[0] > maxX) {
            maxX = actual.raw[0];
        }
        
        if (actual.raw[1] < minY) {
            minY = actual.raw[1];
        } else if(actual.raw[1] > maxY) {
            maxY = actual.raw[1];
        }
    }
    
    GLfloat x = minX;
    GLfloat y = minY;
    GLfloat width = maxX - minX;
    GLfloat height = maxY - minY;
    
    return SRRectMake(x, y, width, height);
}

- (void)draw {
    if (_texture != nil) {
        [_texture bind];
    }
    [_modelMatrixSlot setMatrix:self.transform];
    [_vertexBuffer draw];
}

- (BOOL)collidedWithPoint:(SRPoint)point {
    if ([self.collisionDelegate respondsToSelector:@selector(sprite:collidedWithPoint:)]) {
        return [self.collisionDelegate sprite:self collidedWithPoint:point];
    } else {
        return NO;
    }
}

@end
