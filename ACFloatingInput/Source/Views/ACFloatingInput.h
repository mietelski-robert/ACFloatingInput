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

typedef NS_ENUM(NSInteger, ACTextBorderStyle) {
    ACTextBorderStyleNone,
    ACTextBorderStyleLine,
    ACTextBorderStyleRoundedRect
};

typedef NS_ENUM(NSInteger, ACTextValidationResult) {
    ACTextValidationResultNone,
    ACTextValidationResultPassed,
    ACTextValidationResultFailed
};

typedef NS_ENUM(NSInteger, ACFloatingInputType) {
    ACFloatingInputTypeText,
    ACFloatingInputTypePassword,
    ACFloatingInputTypeSelection,
    ACFloatingInputTypeMultiline,
    ACFloatingInputTypeCustom
};

@class ACTextInputLineView;

@interface ACFloatingInput : UIView

@property (nullable, nonatomic, copy) IBInspectable NSString *hintText;                         // The hint content to display.
@property (nullable, nonatomic, copy) IBInspectable UIColor *hintColor;                         // The color of the hint text.
@property (nullable, nonatomic, copy) IBInspectable UIFont *hintFont;                           // The font of the hint text.
@property (nullable, nonatomic, copy) IBInspectable NSAttributedString *attributedHint;         // The styled hint content to display.

@property (nullable, nonatomic, copy) IBInspectable NSString *placeholderText;                  // The string that is displayed when there is no other text in the text input.
@property (nullable, nonatomic, copy) IBInspectable UIColor *placeholderColor;                  // The color of the placeholder text.
@property (nullable, nonatomic, copy) IBInspectable UIFont *placeholderFont;                    // The font of the placeholder text.
@property (nullable, nonatomic, copy) IBInspectable NSAttributedString *attributedPlaceholder;  // The styled string that is displayed when there is no other text in the text input.

@property (nullable, nonatomic, copy) IBInspectable NSString *text;                             // The text displayed by the text input.
@property (nullable, nonatomic, copy) IBInspectable UIColor *textColor;                         // The color of the text.
@property (nullable, nonatomic, copy) IBInspectable UIFont *textFont;                           // The font of the text.
@property (nullable, nonatomic, copy) IBInspectable NSAttributedString *attributedText;         // The styled text displayed by the text input.

@property (nullable, nonatomic, copy) IBInspectable NSString *errorText;                        // The text displayed below the text input.
@property (nullable, nonatomic, copy) IBInspectable UIColor *errorColor;                        // The color of the error text.
@property (nullable, nonatomic, copy) IBInspectable UIFont *errorFont;                          // The font of the error text.
@property (nullable, nonatomic, copy) IBInspectable NSAttributedString *attributedError;        // The styled text displayed below the text input.

@property (nullable, nonatomic, copy) IBInspectable UIColor *selectedColor;                     // The color of indicator line whether the receiver become first responder.
@property (nullable, nonatomic, copy) IBInspectable UIColor *deselectedColor;                   // The color of indicator line whether the receiver resign first responder.

@property (nullable, nonatomic, strong) UIView *inputAccessoryView;                             // The custom input accessory view to display when the receiver becomes the first responder.
@property (nonatomic, getter=isFloatingEnabled) BOOL floatingEnabled;                           // A Boolean value indicating if hint label should float.
@property (nonatomic, readonly, getter=isEditing) BOOL editing;                                 // A Boolean value indicating whether the text input is currently in edit mode.

@property (nonnull, nonatomic, strong, readonly) ACTextInputView *textInputView;                // The custom input view.
@property (nonnull, nonatomic, strong, readonly) ACTextInputLineView *indicatorLineView;        // The view indicating whether the receiver is the first responder.
@property (nonatomic) UIEdgeInsets textInputInset;                                              // The inset of the text input view.

@property (nullable, nonatomic, weak) id<ACFloatingInputDelegate> delegate;                     // The receiver’s delegate.
@property (nonatomic) ACTextValidationResult validationResult;                                  // The states in which a validated text input can exist.

@property (nonatomic) ACTextBorderStyle borderStyle;                                            // The border style used by the text input.
@property (nonatomic) ACFloatingInputType type;                                                 // The type of the text input.

@property (nonatomic) UITextAutocapitalizationType autocapitalizationType;                      // The auto-capitalization style for the text object.
@property (nonatomic) UITextAutocorrectionType autocorrectionType;                              // The autocorrection style for the text object.

@property (nonatomic) UIReturnKeyType returnKeyType;                                            // The visible title of the Return key.
@property (nonatomic) UIKeyboardType keyboardType;                                              // The keyboard style associated with the text object.

- (void) shake;

@end
