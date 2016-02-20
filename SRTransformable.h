//
//  Transformable.h
//  Sling Rings
//
//  Represents an object that is backed up by a transform matrix.
//  In this case a 4x4 SRMatrix instance. Objects that inherit this class
//  can ask for the transform instance, and get all the transformation
//  methods for free.
//

#import <Foundation/Foundation.h>
#import "SRMatrix.h"

@interface SRTransformable : NSObject

@property(nonatomic, strong) SRMatrix *transform;

- (void)translateBy:(SRPoint)value;
- (void)scaleBy:(SRPoint)value;
- (void)zRotateBy:(GLfloat)value;

@end
