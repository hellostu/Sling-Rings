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

- (instancetype)init
{
    self = [super init];
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
    _sprite.angle += seconds;
    SRRect frame = _sprite.frame;
    frame.y = sinf(_sprite.angle);
    frame.x = cosf(_sprite.angle)/2;
    _sprite.frame = frame;
    
    [self draw];
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Touches
//////////////////////////////////////////////////////////////////////////

- (void)touchMovedToPoint:(SRPoint)point {
    SRPoint worldPoint = [self worldPointFromScreenPoint:point];
    
    if([_sprite collidedWithPoint:worldPoint]) {
        SRRect frame = _sprite.frame;
        frame.x = worldPoint.x;
        frame.y = worldPoint.y;
        _sprite.frame = frame;
    }
}

@end
