//
//  UIView+ACFloatingInput.m
//  Pods
//
//  Created by Robert Mietelski on 10.11.2016.
//  Copyright (c) 2016 mietelski-robert. All rights reserved.
//

#import "UIView+ACFloatingInput.h"

@implementation UIView (ACFloatingInput)

+ (void) transactionAnimationWithDuration:(CFTimeInterval)duration
                            timingFuncion:(CAMediaTimingFunction *)timingFuncion
                               animations:(void (^)(void))animations {
    [CATransaction begin];
    [CATransaction disableActions];
    [CATransaction setAnimationDuration:duration];
    [CATransaction setAnimationTimingFunction:timingFuncion];
    
    if (animations) {
        animations();
    }
    [CATransaction commit];
}

@end
