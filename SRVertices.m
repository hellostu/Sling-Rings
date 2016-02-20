//
//  SRVertices.m
//  Sling Rings
//

#import "SRVertices.h"

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark SRVertices
//////////////////////////////////////////////////////////////////////////

@interface SRVertices () {
    SRVertex *_vertices;
    int _size;
    __weak SRAttribute *_positionAttribute;
    __weak SRAttribute *_colorAttribute;
    __weak SRAttribute *_textureAttribute;
}
@end

@implementation SRVertices

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)initWithSize:(int)size positionAttribute:(SRAttribute *)positionAttribute colorAttribute:(SRAttribute *)colorAttribute textureAttribute:(SRAttribute *)textureAttribute {
    self = [super init];
    if (self) {
        _size = size;
        _vertices =  calloc(size, sizeof(SRVertex));
        _positionAttribute = positionAttribute;
        _colorAttribute = colorAttribute;
        _textureAttribute = textureAttribute;
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
    GLuint positionLocation = _positionAttribute.location;
    GLuint colorLocation = _colorAttribute.location;
    GLuint textureLocation = _textureAttribute.location;
    glVertexAttribPointer(positionLocation, 3, GL_FLOAT, GL_FALSE, sizeof(SRVertex), 0);
    glVertexAttribPointer(colorLocation, 4, GL_FLOAT, GL_FALSE, sizeof(SRVertex), (void *)sizeof(SRPoint));
    glVertexAttribPointer(textureLocation, 2, GL_FLOAT, GL_FALSE, sizeof(SRVertex), (void *)(sizeof(SRPoint) + sizeof(SRColor)));
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
