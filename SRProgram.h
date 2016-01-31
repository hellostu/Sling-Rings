//
//  SRProgram.h
//  Sling Rings
//
//  Created by Stuart Lynch on 29/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#ifndef SRProgram_h
#define SRProgram_h

#import "SRAttribute.h"
#import <Foundation/Foundation.h>
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>
@class SRAttribute;

@interface SRProgram : NSObject

@property(assign, readonly) GLuint value;
@property(readonly, nonatomic) NSArray *shaders;
@property(readonly, nonatomic) SRAttribute *positionAttribute;
@property(readonly, nonatomic) SRAttribute *colorAttribute;

- (id)initWithShaders:(NSArray *)shaders;
- (void)declareAttributeWithName:(NSString *)name isVertexAttribute:(BOOL)vertexAttribute;

@end

#endif