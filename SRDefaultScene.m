//
//  SRDefaultScene.m
//  Sling Rings
//
//  Created by Stuart Lynch on 20/02/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRDefaultScene.h"
#import "SRBoundingBoxCollisionTest.h"
#import "SRCanonSprite.h"
#import "SRTimer.h"

@interface SRDefaultScene () <SRTimerDelegate> {
    SRCanonSprite *_sprite;
    
    SRBoundingBoxCollisionTest *_boundingBoxCollision;
    
    SRTimer *_timer;
}
@end

@implementation SRDefaultScene

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (instancetype)initWithParentView:(UIView *)view
{
    self = [super initWithParentView:view];
    if (self) {
        _boundingBoxCollision = [[SRBoundingBoxCollisionTest alloc] init];
        
        _sprite = (SRCanonSprite *)[self generateNewSpriteWithClass:SRCanonSprite.class];
        _sprite.collisionDelegate = _boundingBoxCollision;
        _timer = [[SRTimer alloc] init];
        _timer.delegate = self;
        [_timer start];
    }
    return self;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark SRTimerDelegate
//////////////////////////////////////////////////////////////////////////

double angle = 0;

- (void)timer:(SRTimer *)timer changedWithSecondsSinceLastCall:(double)seconds {
    
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Touches
//////////////////////////////////////////////////////////////////////////

- (void)touchMovedAtWorldPoint:(SRPoint)point {
    _sprite.worldPointClick = point;
    [self draw];
}

@end
