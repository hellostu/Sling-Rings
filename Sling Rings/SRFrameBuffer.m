//
//  SRFrameBuffer.m
//  Sling Rings
//
//  Created by Stuart Lynch on 29/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRFrameBuffer.h"

@interface SRFrameBuffer ()
@end

@implementation SRFrameBuffer

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)init {
    self = [super init];
    if (self) {
        glGenFramebuffers(1, &_value);
    }
    return self;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Methods
//////////////////////////////////////////////////////////////////////////

- (void)bind {
    glBindFramebuffer(GL_FRAMEBUFFER, _value);
}

@end
