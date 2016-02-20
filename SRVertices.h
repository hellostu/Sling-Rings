//
//  SRVertices.h
//  Sling Rings
//
//  A list of all of the Vertices used to define an object. 
//

#ifndef SRVertices_h
#define SRVertices_h

#import <Foundation/Foundation.h>
#import "SRProgram.h"
#import "SRStructs.h"
#import "SRAttribute.h"
@class SRProgram;

@interface SRVertices : NSObject

@property(readonly) void *raw;
@property(readonly) size_t totalBytes;

- (id)initWithSize:(int)size positionAttribute:(SRAttribute *)positionAttribute colorAttribute:(SRAttribute *)colorAttribute;
- (void)setVertex:(SRVertex)vertex atIndex:(uint)index;
- (SRVertex *)vertexAtIndex:(uint)index;
- (void)load;

@end

#endif