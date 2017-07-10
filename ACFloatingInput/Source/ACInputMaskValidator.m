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

@property (nullable, nonatomic, copy) NSString *replacementText;
@property (nonatomic, assign) NSRange replacementTextRange;

@end

@implementation ACInputMaskValidator

@synthesize blankCharacter = _blankCharacter;
@synthesize inputMask = _inputMask;
@synthesize rawText = _rawText;

@synthesize patternDictionary = _patternDictionary;
@synthesize replacementText = _replacementText;
@synthesize replacementTextRange = _replacementTextRange;

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
#pragma mark Implementation of the protocol ACTextInputDelegate

- (void) textInputDidBeginEditing:(UIView<ACTextInput>* _Nonnull)textInput {
 
    if (![NSString isEmpty:self.inputMask]) {
        
        // Displaying a mask for an empty field
        if ([NSString isEmpty:textInput.text]) {
            textInput.text = [self textWithRawText:self.rawText];
        }
        
        // I set the cursor on the first blank character
        NSRange range = [textInput.text rangeOfString:self.blankCharacter];
        
        if (range.location != NSNotFound) {
            textInput.selectedRange = NSMakeRange(range.location, 0);
        }
    }
}

- (void) textInputDidEndEditing:(UIView<ACTextInput>* _Nonnull)textInput {
    
    if (![NSString isEmpty:self.inputMask]) {
        
        // Displaying empty field if nothing have typed
        if ([NSString isEmpty:self.rawText]) {
            textInput.text = nil;
        }
    }
}

- (void) textInput:(UIView<ACTextInput>* _Nonnull)textInput changeTextInRange:(NSRange)range replacementText:(NSString * _Nullable)text {
    
}

- (void) textInputDidChange:(UIView<ACTextInput>* _Nonnull)textInput {
    self.rawText = [self rawTextWithText:textInput.text];
}

- (BOOL) textInput:(UIView<ACTextInput>* _Nonnull)textInput shouldChangeTextInRange:(NSRange)range replacementText:(NSString * _Nullable)text {
    
    if (![NSString isEmpty:self.inputMask]) {
        NSUInteger numberOfCharacters = [textInput.text numberOfSubstrings:self.blankCharacter];
        
        if (numberOfCharacters == 0 && range.length == 0) {
            return NO;
        }
        
        if (text.length < numberOfCharacters) {
            numberOfCharacters = text.length;
        }
        
        NSInteger location = [textInput.text rangeOfString:self.blankCharacter].location;
        
        if (location > range.location) {
            location = range.location;
        }
        
        for (NSUInteger i = 0; i < numberOfCharacters; i++) {
            
            NSString *maskCharacter = [self.inputMask substringWithRange:NSMakeRange(location + i, 1)];
            NSString *textCharacter = [text substringWithRange:NSMakeRange(i, 1)];
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
    self.replacementTextRange = range;
    self.replacementText = text;
    
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

#pragma mark -
#pragma mark Helper methods

- (NSString *_Nullable) textWithPlainText:(NSString *_Nullable)text {
    return nil;
}

- (NSString *_Nullable) textWithRawText:(NSString *_Nullable)text {
    
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

