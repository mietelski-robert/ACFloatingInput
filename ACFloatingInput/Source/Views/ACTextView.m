//
//  ACTextView.m
//  ACFloatingTextInput
//
//  Created by Robert Mietelski on 30.11.2016.
//  Copyright © 2016 Robert Mietelski. All rights reserved.
//

#import "ACTextView.h"

@implementation ACTextView

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
    self.delegate = self;
}

#pragma mark -
#pragma mark Implementation of the protocol UITextViewDelegate

- (void) textViewDidBeginEditing:(UITextView *)textView {
    
    if (self.textInputDelegate != nil && [self.textInputDelegate respondsToSelector:@selector(textInputDidBeginEditing:)]){
        [self.textInputDelegate textInputDidBeginEditing:self];
    }
}

- (void) textViewDidEndEditing:(UITextView *)textView {
    
    if (self.textInputDelegate != nil && [self.textInputDelegate respondsToSelector:@selector(textInputDidEndEditing:)]){
        [self.textInputDelegate textInputDidEndEditing:self];
    }
}

- (void) textViewDidChange:(UITextView *)textView {
    
    if (self.textInputDelegate != nil && [self.textInputDelegate respondsToSelector:@selector(textInputDidChange:)]){
        [self.textInputDelegate textInputDidChange:self];
    }
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if (self.textInputDelegate != nil && [self.textInputDelegate respondsToSelector:@selector(textInput:shouldChangeTextInRange:replacementText:)]){
        return [self.textInputDelegate textInput:self shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView {
    
    if (self.textInputDelegate != nil && [self.textInputDelegate respondsToSelector:@selector(textInputShouldBeginEditing:)]){
        return [self.textInputDelegate textInputShouldBeginEditing:self];
    }
    return YES;
}

- (BOOL) textViewShouldEndEditing:(UITextView *)textView {
    
    if (self.textInputDelegate != nil && [self.textInputDelegate respondsToSelector:@selector(textInputShouldEndEditing:)]){
        return [self.textInputDelegate textInputShouldEndEditing:self];
    }
    return YES;
}

#pragma mark -
#pragma mark Implementation of the protocol MRTextInputDataSource

- (void) setAutocapitalizationType:(UITextAutocapitalizationType)other {
    
}

- (UITextAutocapitalizationType) autocapitalizationType {
    return UITextAutocapitalizationTypeNone;
}

- (void) setSecureTextEntry:(BOOL)other {
    
}

- (void) setAutocorrectionType:(UITextAutocorrectionType)other {
    
}

- (UITextAutocorrectionType) autocorrectionType {
    return UITextAutocorrectionTypeNo;
}

- (BOOL) isSecureTextEntry {
    return NO;
}

@end
