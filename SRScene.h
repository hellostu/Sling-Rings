//
//  SRScene.h
//  Sling Rings
//
//  This object hides all of the details about Programs & Shaders, and simply
//  exposes a mechanism for creating and drawing sprites onto the screen.
//

#ifndef SRScene_h
#define SRScene_h

@import UIKit;
#import <Foundation/Foundation.h>
#import "SRTransformable.h"
#import "SRAttribute.h"
#import "SRUniform.h"
#import "SRSprite.h"
@class SRSprite;

@interface SRScene : SRTransformable

@property(readwrite, assign) CGSize size;
@property(readwrite, assign) GLfloat contentScaleFactor;

- (void)setRenderBufferLayer:(CAEAGLLayer *)layer;

// Spites & Drawing
- (SRSprite *)generateNewSpriteWithClass:(Class)spriteClass;
- (void)removeSprite:(SRSprite *)sprite;
- (void)draw;

// Coordinate Space Transformations
- (SRPoint)screenPointFromWorldPoint:(SRPoint)point;
- (SRPoint)worldPointFromScreenPoint:(SRPoint)point;

@end

#endif