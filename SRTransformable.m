//
//  Transformable.m
//  Sling Rings
//

#import "SRTransformable.h"

@implementation SRTransformable
@dynamic transform;

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (instancetype)init
{
    self = [super init];
    if (self) {
        _scale = 1.0f;
        _angle = 0.0f;
        _frame = SRRectMake(0.0, 0.0, 2, 2);
        _offset = SRPointMake(0.0, 0.0, 0.0);
    }
    return self;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Methods
//////////////////////////////////////////////////////////////////////////

- (SRMatrix *)transform {
    SRMatrix *root = [SRMatrix identity];
    
    SRMatrix *transform = [SRMatrix translationOf:SRPointMake(_frame.x, _frame.y, 0.0)];
    root = [root multiply:transform];
    
    transform = [SRMatrix scaleOf:SRPointMake(_scale, _scale, 1.0)];
    root = [root multiply:transform];
    
    transform = [SRMatrix zRotate:_angle];
    root = [root multiply:transform];
    
    transform = [SRMatrix scaleOf:SRPointMake(_frame.width / 2.0, _frame.height / 2.0, 1.0)];
    root = [root multiply:transform];
    
    transform = [SRMatrix translationOf:_offset];
    root = [root multiply:transform];
    
    return root;
}

@end
