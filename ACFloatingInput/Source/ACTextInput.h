//
//  ACTextInput.h
//  Pods
//
//  Created by Robert Mietelski on 10.11.2016.
//  Copyright (c) 2016 mietelski-robert. All rights reserved.
//

#ifndef ACTextInput_h
#define ACTextInput_h

#import <UIKit/UIKit.h>

@protocol ACTextInputDelegate;

@protocol ACTextInput <NSObject>

@required
@property (nullable, nonatomic, weak) id<ACTextInputDelegate> textInputDelegate;
@property (nullable, nonatomic, strong) UIView *inputAccessoryView;

@property (nonatomic) UITextAutocapitalizationType autocapitalizationType;
@property (nonatomic) UITextAutocorrectionType autocorrectionType;
@property (nonatomic, getter=isSecureTextEntry) BOOL secureTextEntry;

@property (nonatomic) UIReturnKeyType returnKeyType;
@property (nonatomic) UIKeyboardType keyboardType;

@property (nullable, nonatomic, copy) NSAttributedString *attributedText;
@property (nullable, nonatomic, copy) NSAttributedString *attributedPlaceholder;

@property (nullable, nonatomic, copy) NSString *text;
@property (nullable, nonatomic, copy) NSString *placeholder;

@property (nullable, nonatomic, strong) UIColor *textColor;
@property (nullable, nonatomic, strong) UIColor *placeholderColor;

@property (nullable, nonatomic, strong) UIFont *textFont;
@property (nullable, nonatomic, strong) UIFont *placeholderFont;

@end

@protocol ACTextInputDelegate <NSObject>

@required
- (void) textInputDidBeginEditing:(UIView<ACTextInput>* _Nonnull)textInput;
- (void) textInputDidEndEditing:(UIView<ACTextInput>* _Nonnull)textInput;
- (void) textInputDidChange:(UIView<ACTextInput>* _Nonnull)textInput;
- (BOOL) textInput:(UIView<ACTextInput>* _Nonnull)textInput shouldChangeTextInRange:(NSRange)range replacementText:(NSString * _Nullable)text;
- (BOOL) textInputShouldBeginEditing:(UIView<ACTextInput>* _Nonnull)textInput;
- (BOOL) textInputShouldEndEditing:(UIView<ACTextInput>* _Nonnull)textInput;
- (BOOL) textInputShouldReturn:(UIView<ACTextInput>* _Nonnull)textInput;

@end

#endif /* ACTextInput_h */
