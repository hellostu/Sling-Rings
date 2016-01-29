//
//  OpenGLView.h
//  Sling Rings
//
//  Created by Stuart Lynch on 29/01/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

@import UIKit;
#import "SRRenderBuffer.h"

@interface SROpenGLView : UIView

- (void)initRenderBufferStorage;
- (void)render;

@end
