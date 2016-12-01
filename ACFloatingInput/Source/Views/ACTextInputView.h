//
//  ACTextInputView.h
//  Pods
//
//  Created by Robert Mietelski on 10.11.2016.
//  Copyright (c) 2016 mietelski-robert. All rights reserved.
//

#import "ACTextInput.h"

@interface ACTextInputView : UIControl

@property (nullable, nonatomic, strong) UIView *leftView;
@property (nullable, nonatomic, strong) UIView<ACTextInput> *inputView;
@property (nullable, nonatomic, strong) UIView *rightView;

@end
