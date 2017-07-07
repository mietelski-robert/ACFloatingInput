//
//  ACInputMaskValidator.m
//  Pods
//
//  Created by Robert Mietelski on 11.12.2016.
//  Copyright (c) 2016 mietelski-robert. All rights reserved.
//

#import "ACInputMaskValidator.h"

#import "NSString+ACFloatingInput.h"

@interface ACInputMaskValidator ()

@property (nonnull, nonatomic, strong) NSDictionary *patternDictionary;

@end

@implementation ACInputMaskValidator

@synthesize patternDictionary = _patternDictionary;
@synthesize blankCharacter = _blankCharacter;
@synthesize inputMask = _inputMask;

#pragma mark -
#pragma mark Constructors

- (instancetype) initWithInputMask:(NSString *)inputMask blankCharacter:(NSString *)blankCharacter {
    
    if (self = [super init]) {
        
        self.inputMask = inputMask;
        self.blankCharacter = blankCharacter;
    }
    return self;
}

#pragma mark -
#pragma mark Access methods

- (NSDictionary *) patternDictionary {
    
    if (!_patternDictionary) {
        _patternDictionary = @{@"A":@"[A-Za-z]",
                               @"N":@"[A-Za-z0-9]",
                               @"0":@"[0-9]"};
    }
    return _patternDictionary;
}

#pragma mark -
#pragma mark Managing text masking

- (BOOL) displayText:(NSString *)text shouldChangeInRange:(NSRange)range replacementText:(NSString *)replacementText {
    
    if (![NSString isEmpty:self.inputMask]) {
        NSUInteger numberOfCharacters = [text numberOfSubstrings:self.blankCharacter];
        
        if (numberOfCharacters == 0 && range.length == 0) {
            return NO;
        }
        
        if (replacementText.length < numberOfCharacters) {
            numberOfCharacters = replacementText.length;
        }
        
        NSInteger location = [text rangeOfString:self.blankCharacter].location;
        
        if (location > range.location) {
            location = range.location;
        }
        
        for (NSUInteger i = 0; i < numberOfCharacters; i++) {
            
            NSString *maskCharacter = [self.inputMask substringWithRange:NSMakeRange(location + i, 1)];
            NSString *textCharacter = [replacementText substringWithRange:NSMakeRange(i, 1)];
            NSString *pattern = [self.patternDictionary valueForKey:maskCharacter];
            
            if (![NSString isEmpty:pattern]) {
                if ([textCharacter rangeOfString:pattern options:NSRegularExpressionSearch].location == NSNotFound) {
                    return NO;
                }
            }
            else if (![maskCharacter isEqualToString:textCharacter]) {
                return NO;
            }
        }
    }
    return YES;
}

- (NSString *) displayText:(NSString *)text didChangeInRange:(NSRange)range replacementText:(NSString *)replacementText {
    
    if (![NSString isEmpty:self.inputMask]) {
        NSUInteger numberOfCharacters = replacementText.length;
        
        if (range.length > replacementText.length) {
            numberOfCharacters = range.length;
        }
        
        NSInteger location = [text rangeOfString:self.blankCharacter].location;
        
        if (location > range.location) {
            location = range.location;
        }
        
        NSMutableArray *replacementTextCharacters = [NSMutableArray arrayWithArray:[replacementText characters]];
        NSMutableString *resultText = [NSMutableString stringWithString:text];
        
        for (NSUInteger i = 0; i < numberOfCharacters; i++) {
            
            NSRange letterRange = NSMakeRange(location + i, 1);
            NSString *character = [self.inputMask substringWithRange:letterRange];
            
            if ([self.patternDictionary valueForKey:character] != nil) {
                
                if ([replacementTextCharacters count] > 0) {
                    
                    [resultText replaceCharactersInRange:letterRange withString:replacementTextCharacters.firstObject];
                    [replacementTextCharacters removeObjectAtIndex:0];
                }
                else {
                    [resultText replaceCharactersInRange:letterRange withString:self.blankCharacter];
                }
            }
            else {
                [resultText replaceCharactersInRange:letterRange withString:character];
            }
        }
        return [NSString stringWithString:resultText];
    }
    return [text stringByReplacingCharactersInRange:range withString:replacementText];
}

- (NSString *) rawTextWithDisplayText:(NSString *)text {
    
    if (![NSString isEmpty:self.inputMask]) {
        
        NSMutableArray *displayTextCharacters = [NSMutableArray arrayWithArray:[text characters]];
        NSMutableString *resultText = [NSMutableString string];
        
        for (NSString *character in [self.inputMask characters]) {
            
            if ([self.patternDictionary valueForKey:character] != nil) {
                NSString *letter = [displayTextCharacters firstObject];
                
                if (![NSString isEmpty:letter]) {
                    if (![letter isEqualToString:self.blankCharacter]) {
                        [resultText appendString:letter];
                    }
                    [displayTextCharacters removeObjectAtIndex:0];
                }
            }
            else if ([displayTextCharacters count] > 0) {
                [displayTextCharacters removeObjectAtIndex:0];
            }
        }
        return [NSString stringWithString:resultText];
    }
    return text;
}

- (NSString *) displayTextWithRawText:(NSString *)text {
    
    if (![NSString isEmpty:self.inputMask]) {
        
        NSMutableArray *rawTextCharacters = [NSMutableArray arrayWithArray:[text characters]];
        NSMutableString *resultText = [NSMutableString string];
        
        for (NSString *character in [self.inputMask characters]) {
            
            if ([self.patternDictionary valueForKey:character] != nil) {
                
                if ([rawTextCharacters count] > 0) {
                    
                    [resultText appendString:[rawTextCharacters firstObject]];
                    [rawTextCharacters removeObjectAtIndex:0];
                }
                else {
                    [resultText appendString:self.blankCharacter];
                }
            }
            else {
                [resultText appendString:character];
            }
        }
        return [NSString stringWithString:resultText];
    }
    return text;
}

@end
