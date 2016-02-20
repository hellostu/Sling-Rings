//
//  SRScene.h
//  Sling Rings
//
//  This object hides all of the details about Programs & Shaders, and simply
//  exposes a mechanism for creating and drawing sprites onto the screen.
//

#ifndef SRScene_h
#define SRScene_h

#import <Foundation/Foundation.h>
#import "SRTransformable.h"
#import "SRAttribute.h"
#import "SRUniform.h"
#import "SRSprite.h"

@interface SRScene : SRTransformable

- (SRSprite *)generateNewSprite;
- (void)removeSprite:(SRSprite *)sprite;
- (void)draw;

@end

#endif