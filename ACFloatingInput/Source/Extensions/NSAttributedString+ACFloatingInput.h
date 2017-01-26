//
//  NSAttributedString+ACFloatingInput.h
//  Pods
//
//  Created by Robert Mietelski on 13.12.2016.
//  Copyright (c) 2016 mietelski-robert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface NSAttributedString (ACFloatingInput)

+ (NSDictionary *) attributesWithFontRef:(CTFontRef)fontRef textColorRef:(CGColorRef)colorRef textAlignment:(CTTextAlignment)textAlignment;
+ (NSDictionary *) attributesWithFont:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment;

@end
