//
//  SRScene.h
//  Sling Rings
//
//  Created by Stuart Lynch on 20/02/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#ifndef SRScene_h
#define SRScene_h

#import <Foundation/Foundation.h>
#import "SRAttribute.h"
#import "SRUniform.h"
#import "SRSprite.h"

@interface SRScene : NSObject

@property(nonatomic, strong) SRAttribute *position;
@property(nonatomic, strong) SRAttribute *sourceColor;
@property(nonatomic, strong) SRUniform *viewMatrix;

- (SRSprite *)generateNewSprite;
- (void)removeSprite:(SRSprite *)sprite;
- (void)draw;

@end

#endif