//
//  SRBoundingBoxCollisionTest.m
//  Sling Rings
//
//  Created by Stuart Lynch on 05/03/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRBoundingBoxCollisionTest.h"

@implementation SRBoundingBoxCollisionTest

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark SRSpriteCollisionDelegate
//////////////////////////////////////////////////////////////////////////

- (BOOL)sprite:(SRSprite *)sprite collidedWithPoint:(SRPoint)point {
    SRRect boundingBox = sprite.boundingBox;
    return point.x >= boundingBox.x &&
           point.x <= boundingBox.x + boundingBox.width &&
           point.y >= boundingBox.y &&
           point.y <= boundingBox.y + boundingBox.height;
}

@end
