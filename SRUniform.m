//
//  SRUniform.m
//  Sling Rings
//
//  Created by Stuart Lynch on 20/02/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRUniform.h"

@implementation SRUniform

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)initWithName:(NSString *)name program:(SRProgram *)program {
    self = [super init];
    if (self) {
        _location = glGetUniformLocation(program.value, name.UTF8String);
        glEnableVertexAttribArray(_location);
    }
    return self;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Methods
//////////////////////////////////////////////////////////////////////////

- (void)setMatrix:(SRMatrix *)matrix {
    glUniformMatrix4fv(_location, 1, GL_FALSE, matrix.raw);
}

- (void)setTexture:(SRTexture *)texture {
    [texture bind];
    glUniform1i(_location, 0);
}

@end
