//
//  ACInputMaskValidator.m
//  Pods
//
//  Created by Robert Mietelski on 11.12.2016.
//  Copyright (c) 2016 mietelski-robert. All rights reserved.
//

#import "ACInputMaskValidator.h"

#import "NSString+ACFloatingInput.h"
#import "NSArray+ACFloatingInput.h"

@interface ACInputMaskValidator ()

@property (nullable, nonatomic, strong) NSDictionary<NSString*,NSString*> *patternDictionary;
@property (nullable, nonatomic, strong) NSDictionary<NSNumber*,NSString*> *blankCharacters;

@property (nonatomic, assign) NSRange selectedRange;

@end

@implementation ACInputMaskValidator

@synthesize blankCharacter = _blankCharacter;
@synthesize inputMask = _inputMask;
@synthesize rawText = _rawText;

@synthesize patternDictionary = _patternDictionary;
@synthesize selectedRange = _selectedRange;

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

- (void) setInputMask:(NSString *)other {
    
    // Save property
    _inputMask = [other copy];
    
    // Mapping blank characters
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        @synchronized(self) {
            
            NSMutableDictionary<NSNumber*,NSString*> *dictionary = [NSMutableDictionary<NSNumber*,NSString*> dictionary];
            
            for (NSInteger i = 0; i < other.length; i++) {
                
                NSString *maskCharacter = [other substringWithRange:NSMakeRange(i, 1)];
                NSString *pattern = [self.patternDictionary valueForKey:maskCharacter];
                
                if (![NSString isEmpty:pattern]) {
                    [dictionary setObject:pattern forKey:@(i)];
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.blankCharacters = [NSDictionary<NSNumber*,NSString*> dictionaryWithDictionary:dictionary];
            });
        }
    });
}

- (NSDictionary<NSString*,NSString*> *) patternDictionary {
    
    if (!_patternDictionary) {
        _patternDictionary = @{@"A":@"^[A-Za-z]$",
                               @"a":@"^[A-Za-z]+$",
                               @"N":@"^[A-Za-z0-9]$",
                               @"n":@"^[A-Za-z0-9]+$",
                               @"9":@"^[0-9]$",
                               @"0":@"^[^0-9]+$"};
    }
    return _patternDictionary;
}

#pragma mark -
#pragma mark Implementation of the protocol ACTextInputDelegate

- (void) textInputDidBeginEditing:(UIView<ACTextInput>* _Nonnull)textInput {
 
//    if (![NSString isEmpty:self.inputMask]) {
//        
//        // Displaying a mask for an empty field
//        if ([NSString isEmpty:textInput.text]) {
//            textInput.text = [self textWithRawText:self.rawText];
//        }
//        
//        // I set the cursor on the first blank character
//        NSRange range = [textInput.text rangeOfString:self.blankCharacter];
//        
//        if (range.location != NSNotFound) {
//            textInput.selectedRange = NSMakeRange(range.location, 0);
//        }
//    }
}

- (void) textInputDidEndEditing:(UIView<ACTextInput>* _Nonnull)textInput {
    
//    if (![NSString isEmpty:self.inputMask]) {
//        
//        // Displaying empty field if nothing have typed
//        if ([NSString isEmpty:self.rawText]) {
//            textInput.text = nil;
//        }
//    }
}

- (void) textInputDidChange:(UIView<ACTextInput>* _Nonnull)textInput {
    
    textInput.text = [self textWithRawText:self.rawText];
    textInput.selectedRange = self.selectedRange;
}

- (BOOL) textInput:(UIView<ACTextInput>* _Nonnull)textInput shouldChangeTextInRange:(NSRange)range replacementText:(NSString * _Nullable)text {
    
    if (![NSString isEmpty:self.inputMask]) {
        NSMutableString *resultText = [NSMutableString stringWithString:[NSString isEmpty:self.rawText] ? @"" : self.rawText];
        
        if (range.location < self.inputMask.length) {
            NSInteger location = range.location;
            
            if (![NSString isEmpty:text]) {
                
                for (NSString *textCharacter in [text characters]) {
                    NSString *pattern = nil;
                    
                    do {
                        pattern = [self.blankCharacters objectForKey:@(location)];
                        location += 1;
                    }
                    while ([NSString isEmpty:pattern] && location < self.inputMask.length);
                    
                    if ([textCharacter rangeOfString:pattern options:NSRegularExpressionSearch].location != NSNotFound) {
                        
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF < %@", @(location - 1)];
                        NSInteger index = [[[self.blankCharacters allKeys] filteredArrayUsingPredicate:predicate] count];
                        
                        if (resultText.length > index) {
                            [resultText insertString:textCharacter atIndex:index];
                        }
                        else {
                            [resultText appendString:textCharacter];
                        }
                        self.selectedRange = NSMakeRange(location, 0);
                    }
                    else {
                        return NO;
                    }
                }
            }
            else {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF < %@", @(location)];
                NSArray *indexes = [[self.blankCharacters allKeys] filteredArrayUsingPredicate:predicate];
                
                [resultText deleteCharactersInRange:NSMakeRange([indexes count], range.length)];
                self.selectedRange = NSMakeRange(location - (location - [[indexes valueForKeyPath:@"@max.self"] integerValue]) + 1, 0);
            }
        }
        
        if (resultText.length > self.blankCharacters.count) {
            self.rawText = [resultText substringWithRange:NSMakeRange(0, self.blankCharacters.count)];
        }
        else {
            self.rawText = [NSString stringWithString:resultText];
        }
    }
    else {
        self.rawText = [textInput.text stringByReplacingCharactersInRange:range withString:text];
        self.selectedRange = NSMakeRange(range.location + text.length, 0);
    }
    return YES;
}

- (BOOL) textInputShouldBeginEditing:(UIView<ACTextInput>* _Nonnull)textInput {
    return YES;
}

- (BOOL) textInputShouldEndEditing:(UIView<ACTextInput>* _Nonnull)textInput {
    return YES;
}

- (BOOL) textInputShouldReturn:(UIView<ACTextInput>* _Nonnull)textInput {
    return YES;
}

- (BOOL) textInputShouldClear:(UIView<ACTextInput>* _Nonnull)textInput {
    
    self.selectedRange = NSMakeRange(0, 0);
    self.rawText = nil;
    
    return YES;
}

#pragma mark -
#pragma mark Helper methods

- (NSString *_Nullable) textWithPlainText:(NSString *_Nullable)text {
    return nil;
}

- (NSString *_Nullable) textWithRawText:(NSString *_Nullable)text {
    
    if (![NSString isEmpty:self.inputMask]) {
        
        NSMutableString *resultText = [NSMutableString string];
        NSInteger location = 0;
        
        for (NSInteger i = 0; i < text.length && location < self.inputMask.length; i++) {
            
            NSString *textCharacter = [text substringWithRange:NSMakeRange(i, 1)];
            NSString *maskCharacter = nil;
            NSString *pattern = nil;
            
            do {
                maskCharacter = [self.inputMask substringWithRange:NSMakeRange(location, 1)];
                pattern = [self.patternDictionary valueForKey:maskCharacter];
                
                if ([NSString isEmpty:pattern]) {
                    [resultText appendString:maskCharacter];
                }
                else {
                    [resultText appendString:textCharacter];
                }
                location += 1;
            }
            while ([NSString isEmpty:pattern] && location < self.inputMask.length);
        }
        return [NSString stringWithString:resultText];
    }
    return text;
}

- (NSString *_Nullable) plainTextWithText:(NSString *_Nullable)text {
    return nil;
}

- (NSString *_Nullable) rawTextWithText:(NSString *_Nullable)text {
    
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

@end

