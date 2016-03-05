//
//  SRDefaultScene.m
//  Sling Rings
//
//  Created by Stuart Lynch on 20/02/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRDefaultScene.h"

@implementation SRDefaultScene

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (instancetype)init
{
    self = [super init];
    if (self) {
        SRTexture *texture = [SRTexture named:@"Texture.jpg"];;
        SRSprite *sprite1 = [self generateNewSprite];
        sprite1.texture = texture;
        
        SRSprite *sprite2 = [self generateNewSprite];
        sprite2.texture = texture;
        [sprite2 scaleBy:SRPointMake(0.5, 0.5, 1.0)];
        [sprite2 translateBy:SRPointMake(0.1, 0.1, 0.0)];
    }
    return self;
}

@end
