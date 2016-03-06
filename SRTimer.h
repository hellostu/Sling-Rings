//
//  SRTimer.h
//  Sling Rings
//
//  Created by Stuart Lynch on 06/03/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SRTimer;
@protocol SRTimerDelegate;

@protocol SRTimerDelegate <NSObject>

- (void)timer:(SRTimer *)timer changedWithSecondsSinceLastCall:(double)seconds;

@end

@interface SRTimer : NSObject

- (instancetype)init;
@property(weak, readwrite) id<SRTimerDelegate> delegate;

- (void)start;
- (void)pause;

@end
