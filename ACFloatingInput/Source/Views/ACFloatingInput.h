//
//  ACFloatingInput.h
//  Pods
//
//  Created by Robert Mietelski on 10.11.2016.
//  Copyright (c) 2016 mietelski-robert. All rights reserved.
//

#import "ACTextInputView.h"

@class ACFloatingInput;

@protocol ACFloatingInputDelegate <NSObject>

@optional
- (void) floatingInputDidBeginEditing:(ACFloatingInput * _Nonnull)textInput;
- (void) floatingInputDidEndEditing:(ACFloatingInput * _Nonnull)textInput;
- (void) floatingInputDidChange:(ACFloatingInput * _Nonnull)textInput;
- (void) floatingInputDidSelect:(ACFloatingInput * _Nonnull)textInput;
- (BOOL) floatingInput:(ACFloatingInput * _Nonnull)textInput shouldChangeTextInRange:(NSRange)range replacementText:(NSString * _Nullable)text;
- (BOOL) floatingInputShouldBeginEditing:(ACFloatingInput * _Nonnull)textInput;
- (BOOL) floatingInputShouldEndEditing:(ACFloatingInput * _Nonnull)textInput;
- (BOOL) floatingInputShouldReturn:(ACFloatingInput * _Nonnull)textInput;

@end

typedef enum {
    ACTextBorderStyleNone,
    ACTextBorderStyleLine,
    ACTextBorderStyleRoundedRect
} ACTextBorderStyle;

typedef enum  {
    ACTextValidationResultNone,
    ACTextValidationResultPassed,
    ACTextValidationResultFailed
} ACTextValidationResult;

typedef enum {
    ACFloatingInputTypeText,
    ACFloatingInputTypePassword,
    ACFloatingInputTypeSelection,
    ACFloatingInputTypeMultiline,
    ACFloatingInputTypeCustom
} ACFloatingInputType;

@class ACTextInputLineView;

@interface ACFloatingInput : UIView

@property (nullable, nonatomic, copy) IBInspectable NSString *hintText;
@property (nullable, nonatomic, copy) IBInspectable UIColor *hintColor;
@property (nullable, nonatomic, copy) IBInspectable UIFont *hintFont;
@property (nullable, nonatomic, copy) IBInspectable NSAttributedString *attributedHint;

@property (nullable, nonatomic, copy) IBInspectable NSString *placeholderText;
@property (nullable, nonatomic, copy) IBInspectable UIColor *placeholderColor;
@property (nullable, nonatomic, copy) IBInspectable UIFont *placeholderFont;
@property (nullable, nonatomic, copy) IBInspectable NSAttributedString *attributedPlaceholder;

@property (nullable, nonatomic, copy) IBInspectable NSString *text;
@property (nullable, nonatomic, copy) IBInspectable UIColor *textColor;
@property (nullable, nonatomic, copy) IBInspectable UIFont *textFont;
@property (nullable, nonatomic, copy) IBInspectable NSAttributedString *attributedText;

@property (nullable, nonatomic, copy) IBInspectable NSString *errorText;
@property (nullable, nonatomic, copy) IBInspectable UIColor *errorColor;
@property (nullable, nonatomic, copy) IBInspectable UIFont *errorFont;
@property (nullable, nonatomic, copy) IBInspectable NSAttributedString *attributedError;

@property (nullable, nonatomic, copy) IBInspectable UIColor *selectedColor;
@property (nullable, nonatomic, copy) IBInspectable UIColor *deselectedColor;

@property (nullable, nonatomic, strong) UIView *inputAccessoryView;
@property (nonatomic, getter=isFloatingEnabled) BOOL floatingEnabled;
@property (nonatomic, readonly, getter=isEditing) BOOL editing;

@property (nonnull, nonatomic, strong, readonly) ACTextInputView *textInputView;
@property (nonnull, nonatomic, strong, readonly) ACTextInputLineView *indicatorLineView;
@property (nonatomic) UIEdgeInsets textInputInset;

@property (nullable, nonatomic, weak) id<ACFloatingInputDelegate> delegate;
@property (nonatomic) ACTextValidationResult validationResult;

@property (nonatomic) ACTextBorderStyle borderStyle;
@property (nonatomic) ACFloatingInputType type;

@property (nonatomic) UITextAutocapitalizationType autocapitalizationType;
@property (nonatomic) UITextAutocorrectionType autocorrectionType;

@property (nonatomic) UIReturnKeyType returnKeyType;
@property (nonatomic) UIKeyboardType keyboardType;

- (void) shake;

@end
