//
//  SRSprite.h
//  Sling Rings
//
//  Represents a graphic. A texture is overlaid onto an object described by
//  4 vertices. It can be transformed and move around the screen.
//

#import <Foundation/Foundation.h>
#import "SRTransformable.h"
#import "SRAttribute.h"
#import "SRUniform.h"
#import "SRTexture.h"
#import "SRScene.h"
#import "SRSprite.h"
@class SRSprite;
@class SRScene;

@protocol SRSpriteCollisionDelegate;
@class SRSprite;

@protocol SRSpriteCollisionDelegate <NSObject>

- (BOOL)sprite:(SRSprite *)sprite collidedWithPoint:(SRPoint)point;

@end

@interface SRSprite : SRTransformable

@property(nonatomic, readonly) SRRect boundingBox;
@property(nonatomic, strong) SRTexture *texture;
@property(weak, nonatomic) id<SRSpriteCollisionDelegate> collisionDelegate;

- (id)initWithScene:(SRScene *)scene
  positionAttribute:(SRAttribute *)positionAttribute
     colorAttribute:(SRAttribute *)colorAttribute
   textureAttribute:(SRAttribute *)textureAttribute
        modelMatrix:(SRUniform *)modelMatrix;

- (void)draw;

- (BOOL)collidedWithPoint:(SRPoint)point;

@end
