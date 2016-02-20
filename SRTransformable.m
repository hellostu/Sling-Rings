//
//  Transformable.m
//  Sling Rings
//

#import "SRTransformable.h"

@implementation SRTransformable

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (instancetype)init
{
    self = [super init];
    if (self) {
        _transform = [SRMatrix identity];
    }
    return self;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Methods
//////////////////////////////////////////////////////////////////////////

- (void)translateBy:(SRPoint)value {
    SRMatrix *translation = [SRMatrix translationOf:value];
    _transform = [_transform multiply:translation];
}

- (void)scaleBy:(SRPoint)value {
    SRMatrix *scale = [SRMatrix scaleOf:value];
    _transform = [_transform multiply:scale];
}

- (void)zRotateBy:(GLfloat)value {
    SRMatrix *rotation = [SRMatrix zRotate:value];
    _transform = [_transform multiply:rotation];
}

@end
