//
//  SRSprite.h
//  Sling Rings
//
//  Created by Stuart Lynch on 31/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRProgram.h"

@interface SRSprite : NSObject

- (id)initWithProgram:(SRProgram *)program;
- (void)draw;

@end
