//
//  SRVertices.h
//  Sling Rings
//
//  Created by Stuart Lynch on 30/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#ifndef SRVertices_h
#define SRVertices_h

#import <Foundation/Foundation.h>
#import "SRProgram.h"

typedef struct {
    float x;
    float y;
    float z;
} SRPoint;

typedef struct {
    float r;
    float g;
    float b;
    float a;
} SRColor;

typedef struct {
    SRPoint point;
    SRColor color;
} SRVertex;

SRPoint SRPointMake(float x, float y, float z);
SRColor SRColorMake(float r, float g, float b, float a);
SRVertex SRVertexMake(SRPoint point, SRColor color);

@interface SRVertices : NSObject

@property(readonly) void *raw;
@property(readonly) size_t totalBytes;

- (id)initWithSize:(int)size program:(SRProgram *)program;
- (void)setVertex:(SRVertex)vertex atIndex:(uint)index;
- (SRVertex *)vertexAtIndex:(uint)index;
- (void)load;

@end

#endif