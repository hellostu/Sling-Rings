//
//  SRMatrix.h
//  Sling Rings
//
//  Created by Stuart Lynch on 20/02/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#ifndef SRMatrix_h
#define SRMatrix_h

#import <Foundation/Foundation.h>
#import "SRStructs.h"

#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

@interface SRMatrix : NSObject

@property(assign, readwrite) int width;
@property(assign, readwrite) int height;

@property(assign, readonly) GLfloat *raw;

- (id)initWithHeight:(int)height width:(int)width;

+ (SRMatrix *)identity;
+ (SRMatrix *)translationOf:(SRPoint)point;
+ (SRMatrix *)scaleOf:(SRPoint)point;
+ (SRMatrix *)zRotate:(GLfloat)value;
+ (SRMatrix *)populateProjectionFromFrustumLeft: (GLfloat) left
                                       andRight: (GLfloat) right
                                      andBottom: (GLfloat) bottom
                                         andTop: (GLfloat) top
                                        andNear: (GLfloat) near
                                         andFar: (GLfloat) far;
+ (SRMatrix *)vectorFromPoint:(SRPoint)point;

- (SRMatrix *)transpose;
- (SRMatrix *)multiply:(SRMatrix *)matrix;

- (void)setValue:(GLfloat)value atI:(int)i J:(int)j;
- (GLfloat)valueAtI:(int)i J:(int)j;

@end

#endif