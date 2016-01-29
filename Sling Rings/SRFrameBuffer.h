//
//  SRFrameBuffer.h
//  Sling Rings
//
//  Created by Stuart Lynch on 29/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

@interface SRFrameBuffer : NSObject

@property(assign, readwrite) GLuint value;

- (void)bind;

@end
