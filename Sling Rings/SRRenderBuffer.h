//
//  SRRenderBuffer.h
//  Sling Rings
//
//  Created by Stuart Lynch on 29/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#ifndef SRRenderBuffer_h
#define SRRenderBuffer_h

#import <Foundation/Foundation.h>
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>
#import <QuartzCore/QuartzCore.h>

#import "SRFrameBuffer.h"

@interface SRRenderBuffer : NSObject

@property(assign, readwrite) GLuint value;

- (id)init;
- (void)bind;

@end

#endif