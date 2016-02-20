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
#import "SRStructs.h"
@class SRProgram;

@interface SRVertices : NSObject

@property(readonly) void *raw;
@property(readonly) size_t totalBytes;

- (id)initWithSize:(int)size program:(SRProgram *)program;
- (void)setVertex:(SRVertex)vertex atIndex:(uint)index;
- (SRVertex *)vertexAtIndex:(uint)index;
- (void)load;

@end

#endif