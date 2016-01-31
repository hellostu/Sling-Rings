//
//  SRRenderBuffer.m
//  Sling Rings
//
//  Created by Stuart Lynch on 29/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRRenderBuffer.h"

@interface SRRenderBuffer () {
}
@end

@implementation SRRenderBuffer

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)init {
    self = [super init];
    if (self) {
        glGenRenderbuffers(1, &_value);
        [self bind];
    }
    return self;
}

- (void)dealloc {
    glDeleteRenderbuffers(1, &_value);
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Methods
//////////////////////////////////////////////////////////////////////////

- (void)bind {
    glBindRenderbuffer(GL_RENDERBUFFER, _value);
}

@end
