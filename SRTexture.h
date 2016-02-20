//
//  SRTexture.h
//  Sling Rings
//
//  Created by Stuart Lynch on 20/02/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRTexture : NSObject

@property(assign, readonly) GLuint value;

+ (SRTexture *)named:(NSString *)fileName;
- (void)bind;
- (void)load;

@end
