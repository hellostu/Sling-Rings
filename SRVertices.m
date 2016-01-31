//
//  SRVertices.m
//  Sling Rings
//
//  Created by Stuart Lynch on 30/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRVertices.h"

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark C Methods
//////////////////////////////////////////////////////////////////////////

SRPoint SRPointMake(float x, float y, float z)  {
    SRPoint point;
    point.x = x;
    point.y = y;
    point.z = z;
    return point;
}

SRColor SRColorMake(float r, float g, float b, float a) {
    SRColor color;
    color.r = r;
    color.g = g;
    color.b = b;
    color.a = a;
    return color;
}

SRVertex SRVertexMake(SRPoint point, SRColor color) {
    SRVertex vertex;
    vertex.point = point;
    vertex.color = color;
    return vertex;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark SRVertices
//////////////////////////////////////////////////////////////////////////

@interface SRVertices () {
    SRVertex *_vertices;
    int _size;
    SRProgram *_program;
}
@end

@implementation SRVertices

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)initWithSize:(int)size program:(SRProgram *)program {
    self = [super init];
    if (self) {
        _size = size;
        _vertices =  calloc(size, sizeof(SRVertex));
        _program = program;
    }
    return self;
}

- (void)dealloc {
    free(_vertices);
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Methods
//////////////////////////////////////////////////////////////////////////

- (void)load {    
    GLuint positionLocation = _program.positionAttribute.location;
    GLuint colorLocation = _program.colorAttribute.location;
    glVertexAttribPointer(positionLocation, 3, GL_FLOAT, GL_FALSE, sizeof(SRVertex), 0);
    glVertexAttribPointer(colorLocation, 4, GL_FLOAT, GL_FALSE, sizeof(SRVertex), (void *)sizeof(SRPoint));
}

- (void)setVertex:(SRVertex)vertex atIndex:(uint)index {
    if(index >= _size) {
        NSString *reason = [NSString stringWithFormat:@"Index %d should be less than %d", index, _size];
        @throw [NSException exceptionWithName:@"Index out of bounds" reason:reason userInfo:nil];
    }
    _vertices[index] = vertex;
}

- (SRVertex *)vertexAtIndex:(uint)index {
    if(index >= _size) {
        NSString *reason = [NSString stringWithFormat:@"Index %d should be less than %d", index, _size];
        @throw [NSException exceptionWithName:@"Index out of bounds" reason:reason userInfo:nil];
    }
    return &_vertices[index];
}

- (void *)raw {
    return _vertices;
}

- (size_t)totalBytes {
    return _size * sizeof(SRVertex);
}

@end
