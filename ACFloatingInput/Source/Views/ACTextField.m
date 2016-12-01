//
//  ACTextField.m
//  Pods
//
//  Created by Robert Mietelski on 10.11.2016.
//  Copyright (c) 2016 mietelski-robert. All rights reserved.
//

#import "ACTextField.h"

@implementation ACTextField

@synthesize textInputDelegate = _textInputDelegate;

#pragma mark -
#pragma mark Constructors

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void) commonInit {
    
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.delegate = self;
}

#pragma mark -
#pragma mark Actions

- (void) textFieldDidChange:(ACTextField *)sender {
    
    if (self.textInputDelegate != nil && [self.textInputDelegate respondsToSelector:@selector(textInputDidChange:)]){
        [self.textInputDelegate textInputDidChange:self];
    }
}

#pragma mark -
#pragma mark Implementation of the protocol UITextFieldDelegate

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    
    if (self.textInputDelegate != nil && [self.textInputDelegate respondsToSelector:@selector(textInputDidBeginEditing:)]){
        [self.textInputDelegate textInputDidBeginEditing:self];
    }
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
    
    if (self.textInputDelegate != nil && [self.textInputDelegate respondsToSelector:@selector(textInputDidEndEditing:)]){
        [self.textInputDelegate textInputDidEndEditing:self];
    }
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (self.textInputDelegate != nil && [self.textInputDelegate respondsToSelector:@selector(textInput:shouldChangeTextInRange:replacementText:)]){
        return [self.textInputDelegate textInput:self shouldChangeTextInRange:range replacementText:string];
    }
    return YES;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (self.textInputDelegate != nil && [self.textInputDelegate respondsToSelector:@selector(textInputShouldBeginEditing:)]){
        return [self.textInputDelegate textInputShouldBeginEditing:self];
    }
    return YES;
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    
    if (self.textInputDelegate != nil && [self.textInputDelegate respondsToSelector:@selector(textInputShouldEndEditing:)]){
        return [self.textInputDelegate textInputShouldEndEditing:self];
    }
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    if (self.textInputDelegate != nil && [self.textInputDelegate respondsToSelector:@selector(textInputShouldReturn:)]){
        return [self.textInputDelegate textInputShouldReturn:self];
    }
    return YES;
}

@end
