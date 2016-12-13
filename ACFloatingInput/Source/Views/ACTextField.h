//
//  ACTextField.h
//  Pods
//
//  Created by Robert Mietelski on 10.11.2016.
//  Copyright (c) 2016 mietelski-robert. All rights reserved.
//

#import "ACTextInput.h"

@interface ACTextField : UITextField<UITextFieldDelegate, ACTextInput>

@property (nullable, nonatomic, weak) id<ACTextInputDelegate> textInputDelegate;

@property (nullable, nonatomic, copy) NSAttributedString *attributedPlaceholder;
@property (nullable, nonatomic, copy) NSString *placeholder;

@property (nullable, nonatomic, strong) UIColor *placeholderColor;
@property (nullable, nonatomic, strong) UIFont *placeholderFont;

@end
