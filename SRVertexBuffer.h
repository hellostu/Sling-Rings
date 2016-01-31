//
//  SRVertexBuffer.h
//  Sling Rings
//
//  Created by Stuart Lynch on 30/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#ifndef SRVertexBuffer_h
#define SRVertexBuffer_h

#import <Foundation/Foundation.h>
#import "SRVertices.h"
#import "SRTriangles.h"
#import "SRProgram.h"

@interface SRVertexBuffer : NSObject

@property(readonly, nonatomic) SRVertices *vertices;
@property(readonly, nonatomic) SRTriangles *triangles;

- (id)initWithNumberOfVertices:(int)vertexCount numberOfTriangles:(int)triangleCount program:(SRProgram *)program;
- (void)submit;
- (void)draw;

@end


#endif