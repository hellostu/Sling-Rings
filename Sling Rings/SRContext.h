//
//  SRContext.h
//  Sling Rings
//
//  Created by Stuart Lynch on 29/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "SRRenderBuffer.h"

@interface SRContext : NSObject

- (void)setRenderBufferStorage:(SRRenderBuffer *)renderBuffer withLayer:(CAEAGLLayer *)layer;
- (void)display;

@end
