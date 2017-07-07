//
//  NSString+ACFloatingInput.h
//  Pods
//
//  Created by Robert Mietelski on 10.11.2016.
//  Copyright (c) 2016 mietelski-robert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ACFloatingInput)

+ (BOOL) isEmpty:(NSString *)text;

- (NSUInteger) numberOfSubstrings:(NSString *)substring;
- (NSArray *) characters;

@end
