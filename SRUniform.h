//
//  SRUniform.h
//  Sling Rings
//
//  Created by Stuart Lynch on 20/02/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#ifndef SRUniform_h
#define SRUniform_h

#import <Foundation/Foundation.h>
#import "SRProgram.h"
#import "SRMatrix.h"
#import "SRTexture.h"
@class SRProgram;

@interface SRUniform : NSObject

@property(assign, readonly) GLuint location;

- (id)initWithName:(NSString *)name program:(SRProgram *)program;

- (void)setMatrix:(SRMatrix *)matrix;

@end

#endif