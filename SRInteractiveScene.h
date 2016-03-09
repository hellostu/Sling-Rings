//
//  SRInteractiveScene.h
//  Sling Rings
//
//  Created by Stuart Lynch on 09/03/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRScene.h"

@interface SRInteractiveScene : SRScene

- (instancetype)initWithParentView:(UIView *)view;

//ABSTRACT
- (void)touchBeganAtWorldPoint:(SRPoint)point;
- (void)touchMovedAtWorldPoint:(SRPoint)point;
- (void)touchEndedAtWorldPoint:(SRPoint)point;

@end
