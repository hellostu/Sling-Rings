//
//  SRIndices.m
//  Sling Rings
//
//  Created by Stuart Lynch on 30/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRTriangles.h"

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark C Methods
//////////////////////////////////////////////////////////////////////////

SRTriangle SRTriangleMake(SRIndex a, SRIndex b, SRIndex c) {
    SRTriangle triangle;
    triangle.a = a;
    triangle.b = b;
    triangle.c = c;
    return triangle;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark SRTriangles
//////////////////////////////////////////////////////////////////////////

@interface SRTriangles () {
    SRTriangle *_triangles;
    SRProgram *_program;
    int _size;
}
@end

@implementation SRTriangles

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)initWithSize:(int)size program:(SRProgram *)program {
    self = [super init];
    if (self) {
        _size = size;
        _triangles = calloc(size, sizeof(SRTriangle));
        _program = program;
    }
    return self;
}

- (void)dealloc {
    free(_triangles);
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Methods
//////////////////////////////////////////////////////////////////////////

- (void)setTriangle:(SRTriangle)triangle atIndex:(uint)index {
    if(index >= _size) {
        NSString *reason = [NSString stringWithFormat:@"Index %d should be less than %d", index, _size];
        @throw [NSException exceptionWithName:@"Index out of bounds" reason:reason userInfo:nil];
    }
    _triangles[index] = triangle;
}

- (SRTriangle *)triangleAtIndex:(uint)index {
    if(index >= _size) {
        NSString *reason = [NSString stringWithFormat:@"Index %d should be less than %d", index, _size];
        @throw [NSException exceptionWithName:@"Index out of bounds" reason:reason userInfo:nil];
    }
    return &_triangles[index];
}

- (void *)raw {
    return _triangles;
}

- (size_t)totalBytes {
    return _size * sizeof(SRTriangle);
}

- (void)draw {
    glDrawElements(GL_TRIANGLES, _size * 3, GL_UNSIGNED_SHORT, 0);
}

@end
