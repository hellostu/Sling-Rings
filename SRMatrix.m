//
//  SRMatrix.m
//  Sling Rings
//
//  Created by Stuart Lynch on 20/02/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#define MATRIX_SIZE 4

#import "SRMatrix.h"
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

@interface SRMatrix () {
    GLfloat __matrix[MATRIX_SIZE][MATRIX_SIZE];
}
@end

@implementation SRMatrix
@dynamic raw;

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)init {
    self = [super init];
    if(self) {
        //Init as Identity Matrix
        for (int i = 0; i < MATRIX_SIZE;  i++) {
            for (int j = 0; j < MATRIX_SIZE; j++) {
                if(i==j) {
                    __matrix[i][j] = 1;
                } else {
                    __matrix[i][j] = 0;
                }
                
            }
        }
    }
    return self;
}

+ (SRMatrix *)identity {
    return [[SRMatrix alloc] init];
}

+ (SRMatrix *)translationOf:(SRPoint)point {
    SRMatrix *matrix = [SRMatrix identity];
    [matrix setValue:point.x atI:3 J:0];
    [matrix setValue:point.y atI:3 J:1];
    [matrix setValue:point.z atI:3 J:2];
    return matrix;
}

+ (SRMatrix *)scaleOf:(SRPoint)point {
    SRMatrix *matrix = [SRMatrix identity];
    [matrix setValue:point.x atI:0 J:0];
    [matrix setValue:point.y atI:1 J:1];
    [matrix setValue:point.z atI:2 J:2];
    return matrix;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Properties
//////////////////////////////////////////////////////////////////////////

- (GLfloat *)raw {
    return &(__matrix[0][0]);
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Methods
//////////////////////////////////////////////////////////////////////////

- (SRMatrix *)multiply:(SRMatrix *)matrix {
    SRMatrix *newMatrix = [[SRMatrix alloc] init];
    
    for (int a=0; a<MATRIX_SIZE; a++) {
        for (int b=0; b<MATRIX_SIZE; b++) {
            GLfloat sum = 0;
            for (int c=0; c<MATRIX_SIZE; c++) {
                sum += [self valueAtI:a J:c] * [matrix valueAtI:c J:b];
            }
            [newMatrix setValue:sum atI:a J:b];
        }
    }
    return newMatrix;
}

- (GLfloat)valueAtI:(int)i J:(int)j {
    return __matrix[i][j];
}

- (void)setValue:(GLfloat)value atI:(int)i J:(int)j {
    __matrix[i][j] = value;
}

@end
