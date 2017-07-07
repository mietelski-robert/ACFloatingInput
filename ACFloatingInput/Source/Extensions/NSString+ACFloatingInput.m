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

- (NSUInteger) numberOfSubstrings:(NSString *)substring {
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:substring
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    return [regex numberOfMatchesInString:self
                                  options:kNilOptions
                                    range:NSMakeRange(0, [self length])];
}

- (NSArray *) characters {
    NSMutableArray *characters = [[NSMutableArray alloc] initWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              [characters addObject:substring];
                          }];
    
    return [NSArray arrayWithArray:characters];
}

@end
