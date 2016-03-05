//
//  SRMatrix.m
//  Sling Rings
//
//  Created by Stuart Lynch on 20/02/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRMatrix.h"
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

@interface SRMatrix () {
    GLfloat *_matrix;
}
@end

@implementation SRMatrix
@dynamic raw;

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)initWithHeight:(int)height width:(int)width {
    self = [super init];
    if(self) {
        _matrix = malloc(sizeof(GLfloat) * height * width);
        _width = width;
        _height = height;
        
        //Init as Identity Matrix
        for (int i = 0; i < _height;  i++) {
            for (int j = 0; j < _width; j++) {
                if(i==j) {
                    [self setValue:1 atI:i J:j];
                } else {
                    [self setValue:0 atI:i J:j];
                }
                
            }
        }
    }
    return self;
}

- (void)dealloc {
    free(_matrix);
}

+ (SRMatrix *)vectorFromPoint:(SRPoint)point {
    SRMatrix *matrix = [[SRMatrix alloc] initWithHeight:4 width:1];
    [matrix setValue:point.x atI:0 J:0];
    [matrix setValue:point.y atI:1 J:0];
    [matrix setValue:point.z atI:2 J:0];
    [matrix setValue:1       atI:3 J:0];
    return matrix;

}

+ (SRMatrix *)identity {
    return [[SRMatrix alloc] initWithHeight:4 width:4];
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

+ (SRMatrix *)zRotate:(GLfloat)value {
    GLfloat sin = sinf(value);
    GLfloat cos = cosf(value);
    
    SRMatrix *matrix = [SRMatrix identity];
    [matrix setValue: cos atI:0 J:0];
    [matrix setValue: sin atI:0 J:1];
    [matrix setValue:-sin atI:1 J:0];
    [matrix setValue: cos atI:1 J:1];
    return matrix;
}

+ (SRMatrix *)populateProjectionFromFrustumLeft: (GLfloat) left
                                       andRight: (GLfloat) right
                                      andBottom: (GLfloat) bottom
                                         andTop: (GLfloat) top
                                        andNear: (GLfloat) near
                                         andFar: (GLfloat) far {
    SRMatrix *matrix = [SRMatrix identity];
    [matrix setValue:(2.0 * near) / (right - left)      atI:0 J:0];
    [matrix setValue:0.0                                atI:0 J:1];
    [matrix setValue:0.0                                atI:0 J:2];
    [matrix setValue:0.0                                atI:0 J:3];
    
    [matrix setValue:0.0                                atI:1 J:0];
    [matrix setValue:(2.0 * near) / (top - bottom)      atI:1 J:1];
    [matrix setValue:0.0                                atI:1 J:2];
    [matrix setValue:0.0                                atI:1 J:3];
    
    [matrix setValue:(right + left)/(right - left)      atI:2 J:0];
    [matrix setValue:(top + bottom)/(top - bottom)      atI:2 J:1];
    [matrix setValue:-(far + near) / (far - near)       atI:2 J:2];
    [matrix setValue:-1.0                               atI:2 J:3];
    
    [matrix setValue:0.0                                atI:3 J:0];
    [matrix setValue:0.0                                atI:3 J:1];
    [matrix setValue:-(2.0 * far * near) / (far - near) atI:3 J:2];
    [matrix setValue:0.0                                atI:3 J:3];
    
    return matrix;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Properties
//////////////////////////////////////////////////////////////////////////

- (GLfloat *)raw {
    return _matrix;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Methods
//////////////////////////////////////////////////////////////////////////

- (SRMatrix *)transpose {
    SRMatrix *matrix = [[SRMatrix alloc] initWithHeight:_width width:_height];
    for (int i=0; i<_height; i++) {
        for (int j=0; j<_width; j++) {
            GLfloat value = [self valueAtI:i J:j];
            [matrix setValue:value atI:j J:i];
        }
    }
    return matrix;
}

- (SRMatrix *)multiply:(SRMatrix *)matrix {
    if(self.width != matrix.height) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:@"Inner Sizes in Matrices must match to multiply"
                                     userInfo:nil];
    }
    
    SRMatrix *newMatrix = [[SRMatrix alloc] initWithHeight:self.height width:matrix.width];
    
    for (int a=0; a< self.height; a++) {
        for (int b=0; b< matrix.width; b++) {
            GLfloat sum = 0;
            for (int c=0; c<self.width; c++) {
                sum += [self valueAtI:a J:c] * [matrix valueAtI:c J:b];
            }
            [newMatrix setValue:sum atI:a J:b];
        }
    }
    return newMatrix;
}

- (GLfloat)valueAtI:(int)i J:(int)j {
    return _matrix[i * _width + j];
}

- (void)setValue:(GLfloat)value atI:(int)i J:(int)j {
    if (i < 0 || j < 0) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:@"index must be more than zero"
                                     userInfo:nil];
    }
    
    if (i >= _height) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:@"i must be less than height"
                                     userInfo:nil];
    }
    if (j >= _width) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:@"j must be less than width"
                                     userInfo:nil];
    }
    _matrix[i * _width + j] = value;
}

@end
