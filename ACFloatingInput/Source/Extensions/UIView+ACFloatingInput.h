//
//  UIView+ACFloatingInput.h
//  Pods
//
//  Created by Robert Mietelski on 10.11.2016.
//  Copyright (c) 2016 mietelski-robert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ACFloatingInput)

+ (void) transactionAnimationWithDuration:(CFTimeInterval)duration
                            timingFuncion:(CAMediaTimingFunction *)timingFuncion
                               animations:(void (^)())animations;

@end
