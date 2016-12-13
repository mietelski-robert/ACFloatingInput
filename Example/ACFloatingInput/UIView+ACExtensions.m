//
//  UIView+ACExtensions.m
//  ACFloatingInput
//
//  Created by Robert Mietelski on 13.12.2016.
//  Copyright © 2016 mietelski-robert. All rights reserved.
//

#import "UIView+ACExtensions.h"

@implementation UIView (ACExtensions)

- (void) setCorrnerRadius:(CGFloat)other {
    self.layer.cornerRadius = other;
}

- (CGFloat)corrnerRadius {
    return self.layer.cornerRadius;
}

- (void) setBorderWidth:(CGFloat)other {
    self.layer.borderWidth = other;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void) setBorderColor:(UIColor *)other {
    self.layer.borderColor = other.CGColor;
}

- (UIColor *)borderColor {
    return [[UIColor alloc] initWithCGColor:self.layer.borderColor];
}

@end
