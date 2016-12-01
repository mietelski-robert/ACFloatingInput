//
//  ACTextInputLineView.h
//  Pods
//
//  Created by Robert Mietelski on 10.11.2016.
//  Copyright (c) 2016 mietelski-robert. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ACAnimationTypeLeftToRight,
    ACAnimationTypeRightToLeft
} ACAnimationType;

@interface ACTextInputLineView : UIView

@property (nonatomic) ACAnimationType animationType;
@property (nonatomic) CFTimeInterval animationDuration;
@property (nonatomic, copy) UIColor *defaultColor;

- (void) animateFillLineWithColor:(UIColor *)color;
- (void) animateEmptyLine;

@end
