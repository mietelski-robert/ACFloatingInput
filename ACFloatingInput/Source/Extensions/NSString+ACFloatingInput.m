//
//  NSString+ACFloatingInput.m
//  Pods
//
//  Created by Robert Mietelski on 10.11.2016.
//  Copyright (c) 2016 mietelski-robert. All rights reserved.
//

#import "NSString+ACFloatingInput.h"

@implementation NSString (ACFloatingInput)

+ (BOOL) isEmpty:(NSString *)text {
    return text == nil || [text length] == 0;
}

@end
