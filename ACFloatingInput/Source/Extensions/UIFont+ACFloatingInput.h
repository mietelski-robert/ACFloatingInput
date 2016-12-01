//
//  UIFont+ACFloatingInput.h
//  Pods
//
//  Created by Robert Mietelski on 10.11.2016.
//  Copyright (c) 2016 mietelski-robert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface UIFont (ACFloatingInput)

@property (nonatomic, readonly) CTFontRef CTFont;

+ (UIFont *) fontWithCTFont:(CTFontRef)ctFont;

@end
