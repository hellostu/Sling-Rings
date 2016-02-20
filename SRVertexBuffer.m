//
//  SRVertexBuffer.m
//  Sling Rings
//
//  Created by Stuart Lynch on 30/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRVertexBuffer.h"
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

@interface SRVertexBuffer () {
    GLuint _vertexBuffer;
    GLuint _indexBuffer;
}
@end

@implementation SRVertexBuffer

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)initWithVertices:(SRVertices *)vertices triangles:(SRTriangles *)triangles {
    self = [super init];
    if (self) {
        _vertices = vertices;
        _triangles = triangles;
        
        glGenBuffers(1, &_vertexBuffer);
        glGenBuffers(1, &_indexBuffer);
    }
    return self;
}

- (void)draw {
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    
    [_vertices load];
    [_triangles draw];
}

- (void)dealloc {
    glDeleteBuffers(1, &_vertexBuffer);
    glDeleteBuffers(1, &_indexBuffer);
}

- (void)submit {
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, _vertices.totalBytes, _vertices.raw, GL_STATIC_DRAW);
    
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, _triangles.totalBytes, _triangles.raw, GL_STATIC_DRAW);
}

@end
