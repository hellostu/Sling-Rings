//
//  SRTexture.m
//  Sling Rings
//
//  Created by Stuart Lynch on 20/02/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

@import UIKit;
#import "SRTexture.h"
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

@interface SRTexture () {
    NSString *_fileName;
    
    BOOL _loaded;
}
@end

@implementation SRTexture

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

+ (SRTexture *)named:(NSString *)fileName {
    return [[SRTexture alloc] initWithFileName:fileName];
}

- (instancetype)initWithFileName:(NSString *)fileName
{
    self = [super init];
    if (self) {
        _fileName = fileName;
        _loaded = false;
    }
    return self;
}

- (void)dealloc {
    glDeleteTextures(1, &_value);
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Methods
//////////////////////////////////////////////////////////////////////////

- (void)bind {
    if (_loaded == false) {
        [self load];
    }
    
    glActiveTexture(GL_TEXTURE0); 
    glBindTexture(GL_TEXTURE_2D, _value);
}

- (void)load {
    CGImageRef spriteImage = [UIImage imageNamed:_fileName].CGImage;
    if (!spriteImage) {
        NSLog(@"Failed to load image %@", _fileName);
        exit(1);
    }
    
    GLsizei width = (GLsizei)CGImageGetWidth(spriteImage);
    GLsizei height = (GLsizei)CGImageGetHeight(spriteImage);
    
    GLubyte * spriteData = (GLubyte *) calloc(width*height*4, sizeof(GLubyte));
    
    CGContextRef spriteContext = CGBitmapContextCreate(spriteData, width, height, 8, width*4,
                                                       CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
    
    CGContextDrawImage(spriteContext, CGRectMake(0, 0, width, height), spriteImage);
    CGContextRelease(spriteContext);
    
    glGenTextures(1, &_value);
    glBindTexture(GL_TEXTURE_2D, _value);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
    
    free(spriteData);
    _loaded = true;
}

@end
