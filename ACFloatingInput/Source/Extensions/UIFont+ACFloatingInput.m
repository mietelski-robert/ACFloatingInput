//
//  UIFont+ACFloatingInput.m
//  Pods
//
//  Created by Robert Mietelski on 10.11.2016.
//  Copyright (c) 2016 mietelski-robert. All rights reserved.
//

#import "UIFont+ACFloatingInput.h"

@implementation UIFont (ACFloatingInput)

- (CTFontRef) CTFont {
    return CTFontCreateWithName((__bridge CFStringRef)self.fontName, self.pointSize, NULL);
}

+ (UIFont *) fontWithCTFont:(CTFontRef)ctFont {
    return [UIFont fontWithName:(NSString *)CFBridgingRelease(CTFontCopyName(ctFont, kCTFontPostScriptNameKey))
                           size:CTFontGetSize(ctFont)];
}

@end
