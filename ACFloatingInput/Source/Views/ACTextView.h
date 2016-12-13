//
//  ACTextView.h
//  ACFloatingTextInput
//
//  Created by Robert Mietelski on 30.11.2016.
//  Copyright © 2016 Robert Mietelski. All rights reserved.
//

#import "ACTextInput.h"

@interface ACTextView : UITextView<UITextViewDelegate, ACTextInput>

@property (nullable, nonatomic, weak) id<ACTextInputDelegate> textInputDelegate;

@property (nullable, nonatomic, copy) NSAttributedString *attributedPlaceholder;
@property (nullable, nonatomic, copy) NSString *placeholder;

@property (nullable, nonatomic, strong) UIColor *placeholderColor;
@property (nullable, nonatomic, strong) UIFont *placeholderFont;

@end
