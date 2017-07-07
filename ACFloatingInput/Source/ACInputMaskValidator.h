//
//  ACInputMaskValidator.h
//  Pods
//
//  Created by Robert Mietelski on 11.12.2016.
//  Copyright (c) 2016 mietelski-robert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACInputMaskValidator : NSObject

@property (nullable, nonatomic, copy) NSString *blankCharacter;
@property (nullable, nonatomic, copy) NSString *inputMask;

- (instancetype) initWithInputMask:(NSString *_Nullable)inputMask blankCharacter:(NSString *_Nullable)blankCharacter;

- (BOOL) displayText:(NSString *_Nullable)text shouldChangeInRange:(NSRange)range replacementText:(NSString *_Nullable)replacementText;
- (NSString *_Nullable) displayText:(NSString *_Nullable)text didChangeInRange:(NSRange)range replacementText:(NSString *_Nullable)replacementText;

- (NSString *_Nullable) rawTextWithDisplayText:(NSString *_Nullable)text;
- (NSString *_Nullable) displayTextWithRawText:(NSString *_Nullable)text;

@end
