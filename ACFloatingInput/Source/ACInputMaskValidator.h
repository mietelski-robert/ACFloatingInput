//
//  ACInputMaskValidator.h
//  Pods
//
//  Created by Robert Mietelski on 11.12.2016.
//  Copyright (c) 2016 mietelski-robert. All rights reserved.
//

#import "ACTextInput.h"

@interface ACInputMaskValidator : NSObject<ACTextInputDelegate>

@property (nullable, nonatomic, copy) NSString *blankCharacter;
@property (nullable, nonatomic, copy) NSString *inputMask;
@property (nullable, nonatomic, copy) NSString *rawText;

- (NSString *_Nullable) textWithPlainText:(NSString *_Nullable)text;
- (NSString *_Nullable) textWithRawText:(NSString *_Nullable)text;

- (NSString *_Nullable) plainTextWithText:(NSString *_Nullable)text;
- (NSString *_Nullable) rawTextWithText:(NSString *_Nullable)text;

@end
