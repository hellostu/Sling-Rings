//
//  SRTimer.m
//  Sling Rings
//
//  Created by Stuart Lynch on 06/03/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRTimer.h"
#import <QuartzCore/QuartzCore.h>

@interface SRTimer () {
    NSTimer *_timer;
    double _previousRecordedTime;
}

@end

@implementation SRTimer

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (instancetype)init {
    if ( (self = [super init]) != nil) {
        
    }
    return self;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Functions
//////////////////////////////////////////////////////////////////////////

- (void)start {
    if (_timer != nil) { return; }
    
    _timer = [NSTimer timerWithTimeInterval:1.0/60.0 target:self selector:@selector(update:) userInfo:nil repeats:YES];
    _previousRecordedTime = CACurrentMediaTime();
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

- (void)pause {
    [_timer invalidate];
    _timer = nil;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Timer Function
//////////////////////////////////////////////////////////////////////////

- (void)update:(NSTimer *)timer {
    double currentTime = CACurrentMediaTime();
    double diff = currentTime - _previousRecordedTime;
    
    if ([self.delegate respondsToSelector:@selector(timer:changedWithSecondsSinceLastCall:)]) {
        [self.delegate timer:self changedWithSecondsSinceLastCall:diff];
    }
}

@end
