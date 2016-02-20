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

@interface SRSprite : SRTransformable

- (id)initWithPositionAttribute:(SRAttribute *)positionAttribute colorAttribute:(SRAttribute *)colorAttribute modelMatrix:(SRUniform *)modelMatrix;
- (void)draw;

@end
