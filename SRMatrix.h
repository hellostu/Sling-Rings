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

@property(assign, readonly) GLfloat *raw;

+ (SRMatrix *)identity;
+ (SRMatrix *)translationOf:(SRPoint)point;
+ (SRMatrix *)scaleOf:(SRPoint)point;
+ (SRMatrix *)zRotate:(GLfloat)value;

- (SRMatrix *)multiply:(SRMatrix *)matrix;

- (void)setValue:(GLfloat)value atI:(int)i J:(int)j;
- (GLfloat)valueAtI:(int)i J:(int)j;

@end

#endif