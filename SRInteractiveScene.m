//
//  SRInteractiveScene.m
//  Sling Rings
//
//  Created by Stuart Lynch on 09/03/2016.
//  Copyright © 2016 uea.ac.uk. All rights reserved.
//

#import "SRInteractiveScene.h"

@interface SRInteractiveScene()<UIGestureRecognizerDelegate> {
    UIPanGestureRecognizer      *_panGesture;
    UIPinchGestureRecognizer    *_pinchGesture;
    
    SRPoint                     _lastWorldPoint;
    float                       _lastScale;
    
    BOOL                        _oneFingerTap;
}

@end

@implementation SRInteractiveScene

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (instancetype)initWithParentView:(UIView *)view {
    if ( (self = [super init]) != nil) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
        _pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinched:)];
        _panGesture.delegate = self;
        _pinchGesture.delegate = self;
        
        [view addGestureRecognizer:_panGesture];
        [view addGestureRecognizer:_pinchGesture];
    }
    return self;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIGestureRecognizerDelegate
//////////////////////////////////////////////////////////////////////////

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Actions
//////////////////////////////////////////////////////////////////////////

- (void)panned:(UIPanGestureRecognizer *)panGesture {
    CGPoint location = [panGesture locationInView:panGesture.view];
    SRPoint currentWorldPoint = [self worldPointFromScreenPoint:SRPointMake(location.x, location.y, 0.0)];
    
    if (panGesture.numberOfTouches == 2) {
        _oneFingerTap = NO;
        
        switch (panGesture.state) {
            case UIGestureRecognizerStateChanged: {
                SRPoint diff = SRPointMake(currentWorldPoint.x - _lastWorldPoint.x, currentWorldPoint.y - _lastWorldPoint.y, 0.0);
                [self pannedWithDiff:diff];
                break;
            }
            default:
                break;
        }
        
        _lastWorldPoint = currentWorldPoint;
    } else if (panGesture.numberOfTouches == 1) {
        
        
        switch (panGesture.state) {
            case UIGestureRecognizerStateBegan: {
                _oneFingerTap = YES;
                [self touchBeganAtWorldPoint:[self applyTransformToPoint:currentWorldPoint]];
                break;
            }
            case UIGestureRecognizerStateChanged: {
                if (_oneFingerTap) {
                    [self touchMovedAtWorldPoint:[self applyTransformToPoint:currentWorldPoint]];
                }
                break;
            }
            case UIGestureRecognizerStateEnded:
            case UIGestureRecognizerStateCancelled: {
                if (_oneFingerTap) {
                    [self touchEndedAtWorldPoint:[self applyTransformToPoint:currentWorldPoint]];
                }
                break;
            }
            default:
                break;
        }
    }
}

- (void)touchBeganAtWorldPoint:(SRPoint)point {
    //Free to be overriden
}

- (void)touchMovedAtWorldPoint:(SRPoint)point {
    //Free to be overriden
}

- (void)touchEndedAtWorldPoint:(SRPoint)point {
    //Free to be overriden
}

- (SRPoint)applyTransformToPoint:(SRPoint)point {
    SRMatrix *vec = [SRMatrix vectorFromPoint:point];
    SRMatrix *newVec = [[self.transform inverse] multiply:vec];
    return SRPointMake(newVec.raw[0], newVec.raw[1], 0.0);
}

- (void)pannedWithDiff:(SRPoint)diff {
    SRRect frame = self.frame;
    frame.x += diff.x;
    frame.y += diff.y;
    self.frame = frame;
    [self draw];
}

- (void)pinched:(UIPinchGestureRecognizer *)pinchGesture {
    float currentScale = pinchGesture.scale;
    
    switch (pinchGesture.state) {
        case UIGestureRecognizerStateChanged: {
            float diff = currentScale / _lastScale;
            [self pinchedWithDiff:diff];
            break;
        }
        default:
            break;
    }
    
    _lastScale = currentScale;
}

- (void)pinchedWithDiff:(float)diff {
    self.scale *= diff;
    [self draw];
}

@end
