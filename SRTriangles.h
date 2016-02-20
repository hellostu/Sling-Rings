//
//  SRIndices.h
//  Sling Rings
//
//  Created by Stuart Lynch on 30/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#ifndef SRTriangles_h
#define SRTriangles_h

#import <Foundation/Foundation.h>
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>
#import "SRProgram.h"

typedef GLushort SRIndex;

typedef struct {
    SRIndex a;
    SRIndex b;
    SRIndex c;
} SRTriangle;

SRTriangle SRTriangleMake(SRIndex a, SRIndex b, SRIndex c);

@interface SRTriangles : NSObject

- (id)initWithSize:(int)size;

@property(readonly) void *raw;
@property(readonly) size_t totalBytes;

- (void)setTriangle:(SRTriangle)triangle atIndex:(uint)index;
- (SRTriangle *)triangleAtIndex:(uint)index;
- (void)draw;

@end

#endif
