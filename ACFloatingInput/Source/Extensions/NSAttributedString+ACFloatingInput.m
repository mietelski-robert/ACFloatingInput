//
//  NSAttributedString+ACFloatingInput.m
//  Pods
//
//  Created by Robert Mietelski on 13.12.2016.
//  Copyright (c) 2016 mietelski-robert. All rights reserved.
//

#import "NSAttributedString+ACFloatingInput.h"

@implementation NSAttributedString (ACFloatingInput)

+ (NSDictionary *) attributesWithFontRef:(CTFontRef)fontRef textColorRef:(CGColorRef)colorRef textAlignment:(CTTextAlignment)textAlignment {
    
    CTParagraphStyleSetting alignmentSetting;
    alignmentSetting.spec = kCTParagraphStyleSpecifierAlignment;
    alignmentSetting.valueSize = sizeof(CTTextAlignment);
    alignmentSetting.value = &textAlignment;
    
    CTParagraphStyleSetting settings[1] = {alignmentSetting};
    size_t settingsCount = 1;
    CTParagraphStyleRef paragraphRef = CTParagraphStyleCreate(settings, settingsCount);
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    if (fontRef != nil) {
        [attributes setObject:(__bridge id _Nonnull)(fontRef) forKey:(__bridge NSString *)kCTFontAttributeName];
    }
    if (colorRef != nil) {
        [attributes setObject:(__bridge id _Nonnull)(colorRef) forKey:(__bridge NSString *)kCTForegroundColorAttributeName];
    }
    return [NSDictionary dictionaryWithDictionary:attributes];
}

+ (NSDictionary *) attributesWithFont:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = textAlignment;
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:@{NSParagraphStyleAttributeName: paragraphStyle}];
    
    if (font != nil) {
        [attributes setObject:font forKey:NSFontAttributeName];
    }
    if (color != nil) {
        [attributes setObject:color forKey:NSForegroundColorAttributeName];
    }
    return [NSDictionary dictionaryWithDictionary:attributes];
}

@end
