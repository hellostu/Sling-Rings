//
//  SRDefaultScene.m
//  Sling Rings
//
//  Created by Stuart Lynch on 20/02/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRDefaultScene.h"
#import "SRBoundingBoxCollisionTest.h"

@interface SRDefaultScene () {
    SRSprite *_sprite;
    
    SRBoundingBoxCollisionTest *_boundingBoxCollision;
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
        
        SRTexture *texture = [SRTexture named:@"Texture.jpg"];;
        _sprite = [self generateNewSprite];
        _sprite.texture = texture;
        _sprite.collisionDelegate = _boundingBoxCollision;
        [_sprite scaleBy:SRPointMake(0.5, 0.5, 1.0)];
    }
    return self;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Touches
//////////////////////////////////////////////////////////////////////////

- (void)touchMovedToPoint:(SRPoint)point {
    SRPoint worldPoint = [self worldPointFromScreenPoint:point];
    
    if([_sprite collidedWithPoint:worldPoint]) {
        _sprite.transform = [SRMatrix identity];
        [_sprite translateBy:worldPoint];
        [_sprite scaleBy:SRPointMake(0.5, 0.5, 1.0)];
    }
    
    [self draw];
}

@end
