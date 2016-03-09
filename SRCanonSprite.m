//
//  SRCanonSprite.m
//  Sling Rings
//
//  Created by Stuart Lynch on 06/03/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRCanonSprite.h"

#define degreesToRadians( degrees ) ( ( degrees ) / 180.0 * M_PI )

@implementation SRCanonSprite

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (void)setupSprite {
    self.frame = SRRectMake(0.0, 0.0, 0.5, 0.1);
    self.offset = SRPointMake(0.4, 0.05, 0.0);
    self.angle = 0.785398;
    self.backgroundColor = SRColorMake(1.0, 1.0, 1.0, 1.0);
}

@end
