//
//  SRAttribute.m
//  Sling Rings
//
//  Created by Stuart Lynch on 29/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRAttribute.h"

@interface SRAttribute () {
    BOOL _vertexAttribute;
}
@end

@implementation SRAttribute

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)initWithName:(NSString *)name program:(SRProgram *)program {
    self = [super init];
    if (self) {
        _location = glGetAttribLocation(program.value, name.UTF8String);
        glEnableVertexAttribArray(_location);
    }
    return self;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Methods
//////////////////////////////////////////////////////////////////////////

- (BOOL)vertexAttribute {
    return _vertexAttribute;
}

- (void)setVertexAttribute:(BOOL)vertexAttribute {
    _vertexAttribute = vertexAttribute;
    if(_vertexAttribute) {
        glEnableVertexAttribArray(_location);
    } else {
        glDisableVertexAttribArray(_location);
    }
}

@end
