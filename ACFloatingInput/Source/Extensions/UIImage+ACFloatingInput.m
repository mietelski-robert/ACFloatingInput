//
//  UIImage+ACFloatingInput.m
//  Pods
//
//  Created by Robert Mietelski on 10.11.2016.
//  Copyright (c) 2016 mietelski-robert. All rights reserved.
//

#import "UIImage+ACFloatingInput.h"

@implementation UIImage (ACFloatingInput)

- (UIImage *) imageWithTintColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawInRect:rect];
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextSetBlendMode(context, kCGBlendModeSourceAtop);
    CGContextFillRect(context, rect);
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

@end
