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

- (id)initWithWidth:(int)width height:(int)height {
    self = [super init];
    if(self) {
        _matrix = malloc(sizeof(GLfloat) * width * height);
        _width = width;
        _height = height;
        
        //Init as Identity Matrix
        for (int i = 0; i < _height;  i++) {
            for (int j = 0; j < _width; j++) {
                if(i==j) {
                    _matrix[i*_height + j] = 1;
                } else {
                    _matrix[i*_height + j] = 0;
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
    SRMatrix *matrix = [[SRMatrix alloc] initWithWidth:1 height:4];
    [matrix setValue:point.x atI:0 J:0];
    [matrix setValue:point.y atI:1 J:0];
    [matrix setValue:point.z atI:2 J:0];
    [matrix setValue:1       atI:3 J:0];
    return matrix;

}

+ (SRMatrix *)identity {
    return [[SRMatrix alloc] initWithWidth:4 height:4];
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
    SRMatrix *matrix = [[SRMatrix alloc] initWithWidth:_height height:_width];
    for (int i=0; i<_width; i++) {
        for (int j=0; j<_height; j++) {
            GLfloat value = [self valueAtI:i J:j];
            [matrix setValue:value atI:j J:i];
        }
    }
    return matrix;
}

- (SRMatrix *)multiply:(SRMatrix *)matrix {
    if(matrix.height != self.width) {
        @throw [NSException exceptionWithName:@"Inner Sizes in Matrices must match to multiply" reason:@"" userInfo:nil];
    }
    
    SRMatrix *newMatrix = [[SRMatrix alloc] initWithWidth:matrix.width height:self.height];
    
    for (int a=0; a<_height; a++) {
        for (int b=0; b<_width; b++) {
            GLfloat sum = 0;
            for (int c=0; c<_width; c++) {
                sum += [self valueAtI:a J:c] * [matrix valueAtI:c J:b];
            }
            [newMatrix setValue:sum atI:a J:b];
        }
    }
    return newMatrix;
}

- (GLfloat)valueAtI:(int)i J:(int)j {
    return _matrix[i * _height + j];
}

- (void)setValue:(GLfloat)value atI:(int)i J:(int)j {
    _matrix[i * _height + j] = value;
}

@end
