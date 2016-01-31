//
//  SRAttribute.h
//  Sling Rings
//
//  Created by Stuart Lynch on 29/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#ifndef SRAttribute_h
#define SRAttribute_h

#import <Foundation/Foundation.h>
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>
#import "SRProgram.h"
@class SRProgram;

@interface SRAttribute : NSObject

@property(assign, readonly) GLuint location;
@property(assign, readwrite) BOOL vertexAttribute;

- (id)initWithName:(NSString *)name program:(SRProgram *)program;

@end

#endif
