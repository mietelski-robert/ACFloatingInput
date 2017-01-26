//
//  ACTextView.m
//  ACFloatingTextInput
//
//  Created by Robert Mietelski on 30.11.2016.
//  Copyright © 2016 Robert Mietelski. All rights reserved.
//

#import "ACTextView.h"

#import "NSAttributedString+ACFloatingInput.h"
#import "NSString+ACFloatingInput.h"

@interface ACTextView ()

@property (nonatomic, strong, readonly) UILabel *placeholderLabel;

@property (nonatomic, strong) NSLayoutConstraint *placeholderLabelTopConstraint;
@property (nonatomic, strong) NSLayoutConstraint *placeholderLabelLeadingConstraint;
@property (nonatomic, strong) NSLayoutConstraint *placeholderLabelBottomConstraint;
@property (nonatomic, strong) NSLayoutConstraint *placeholderLabelTrailingConstraint;
@property (nonatomic, strong) NSLayoutConstraint *placeholderLabelWidthConstraint;

@end

@implementation ACTextView

@synthesize textInputDelegate = _textInputDelegate;

@synthesize placeholderTextAlignment = _placeholderTextAlignment;
@synthesize attributedPlaceholder = _attributedPlaceholder;
@synthesize placeholder = _placeholder;

@synthesize placeholderColor = _placeholderColor;
@synthesize placeholderFont = _placeholderFont;

@synthesize placeholderLabel = _placeholderLabel;

@synthesize placeholderLabelTopConstraint = _placeholderLabelTopConstraint;
@synthesize placeholderLabelLeadingConstraint = _placeholderLabelLeadingConstraint;
@synthesize placeholderLabelBottomConstraint = _placeholderLabelBottomConstraint;
@synthesize placeholderLabelTrailingConstraint = _placeholderLabelTrailingConstraint;
@synthesize placeholderLabelWidthConstraint = _pplaceholderLabelWidthConstraint;

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
    
    self.textAlignment = NSTextAlignmentLeft;
    self.delegate = self;
}

#pragma mark -
#pragma mark Managing constraints

- (void) updateConstraints {
    
    if (!self.placeholderLabelTopConstraint) {
        self.placeholderLabelTopConstraint = [NSLayoutConstraint constraintWithItem:self.placeholderLabel
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self
                                                                          attribute:NSLayoutAttributeTop
                                                                         multiplier:1.0
                                                                           constant:self.textContainerInset.top];
        self.placeholderLabelTopConstraint.active = YES;
    }
    else {
        self.placeholderLabelTopConstraint.constant = self.textContainerInset.top;
    }
    
    if (!self.placeholderLabelLeadingConstraint) {
        self.placeholderLabelLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.placeholderLabel
                                                                              attribute:NSLayoutAttributeLeading
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self
                                                                              attribute:NSLayoutAttributeLeading
                                                                             multiplier:1.0
                                                                               constant:self.textContainerInset.left];
        self.placeholderLabelLeadingConstraint.active = YES;
    }
    else {
        self.placeholderLabelLeadingConstraint.constant = self.textContainerInset.left;
    }
    
    if (!self.placeholderLabelBottomConstraint) {
        self.placeholderLabelBottomConstraint = [NSLayoutConstraint constraintWithItem:self.placeholderLabel
                                                                             attribute:NSLayoutAttributeBottom
                                                                             relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                                toItem:self
                                                                             attribute:NSLayoutAttributeBottom
                                                                            multiplier:1.0
                                                                              constant:self.textContainerInset.bottom];
        self.placeholderLabelBottomConstraint.active = YES;
    }
    else {
        self.placeholderLabelBottomConstraint.constant = self.textContainerInset.bottom;
    }
    
    if (!self.placeholderLabelTrailingConstraint) {
        self.placeholderLabelTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.placeholderLabel
                                                                               attribute:NSLayoutAttributeTrailing
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self
                                                                               attribute:NSLayoutAttributeTrailing
                                                                              multiplier:1.0
                                                                                constant:self.textContainerInset.right];
        self.placeholderLabelTrailingConstraint.active = YES;
    }
    else {
        self.placeholderLabelTrailingConstraint.constant = self.textContainerInset.right;
    }
    
    const CGFloat constant = -(self.textContainerInset.left + self.textContainerInset.right);
    
    if (!self.placeholderLabelWidthConstraint) {
        self.placeholderLabelWidthConstraint = [NSLayoutConstraint constraintWithItem:self.placeholderLabel
                                                                            attribute:NSLayoutAttributeWidth
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self
                                                                            attribute:NSLayoutAttributeWidth
                                                                           multiplier:1.0
                                                                             constant:constant];
        self.placeholderLabelWidthConstraint.active = YES;
    }
    else {
        self.placeholderLabelWidthConstraint.constant = constant;
    }
    [super updateConstraints];
}

#pragma mark -
#pragma mark Access methods

- (void) setText:(NSString *)other {
    
    // Save property
    [super setText:other];
    
    // Update user interface
    self.placeholderLabel.hidden = ![NSString isEmpty:other];
}

- (void) setPlaceholderTextAlignment:(NSTextAlignment)other {
    
    // Save property
    _placeholderTextAlignment = other;
    
    // Update user interface
    self.placeholderLabel.textAlignment = other;
}

- (void) setAttributedText:(NSAttributedString *)other {
    
    // Save property
    [super setAttributedText:other];
    
    // Update user interface
    self.placeholderLabel.hidden = ![NSString isEmpty:other.string];
}

- (void) setPlaceholder:(NSString *)other {
    
    // Save property
    _placeholder = [other copy];
    
    // Update user interface
    self.placeholderLabel.text = other;
}

- (void) setPlaceholderColor:(UIColor *)other {
    
    // Save property
    _placeholderColor = [other copy];
    
    // Update user interface
    self.placeholderLabel.textColor = other;
}

- (void) setPlaceholderFont:(UIFont *)other {
    
    // Save property
    _placeholderFont = [other copy];
    
    // Update user interface
    self.placeholderLabel.font = other;
}

- (void) setAttributedPlaceholder:(NSAttributedString *)other {
    
    // Save property
    _attributedPlaceholder = [other copy];
    
    // Update user interface
    self.placeholderLabel.attributedText = other;
}

- (NSAttributedString *) attributedPlaceholder {
    
    if (!_attributedPlaceholder) {
        if (![NSString isEmpty:self.placeholder]) {
            NSDictionary *attributes = [NSAttributedString attributesWithFont:self.placeholderFont
                                                                    textColor:self.placeholderColor
                                                                textAlignment:self.textAlignment];
            
            return [[NSAttributedString alloc] initWithString:self.placeholder
                                                   attributes:attributes];
        }
    }
    return _attributedPlaceholder;
}

#pragma mark -
#pragma mark Managing subviews

- (UILabel *) placeholderLabel {
    
    if (!_placeholderLabel) {
        
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _placeholderLabel.backgroundColor = [UIColor clearColor];
        _placeholderLabel.textAlignment = self.textAlignment;
        _placeholderLabel.attributedText = self.attributedPlaceholder;
        _placeholderLabel.textColor = self.placeholderColor;
        _placeholderLabel.font = self.placeholderFont;
        _placeholderLabel.numberOfLines = 0;
        [_placeholderLabel sizeToFit];
        [self addSubview:_placeholderLabel];
    }
    return _placeholderLabel;
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
    self.placeholderLabel.hidden = ![NSString isEmpty:textView.text];
    
    if (self.textInputDelegate != nil && [self.textInputDelegate respondsToSelector:@selector(textInputDidChange:)]){
        [self.textInputDelegate textInputDidChange:self];
    }
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        if (self.textInputDelegate != nil && [self.textInputDelegate respondsToSelector:@selector(textInputShouldReturn:)]){
            return [self.textInputDelegate textInputShouldReturn:self];
        }
        return YES;
    }
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
#pragma mark Implementation of the protocol ACTextInput

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

- (void) setTextFont:(UIFont *)textFont {
    self.font = textFont;
}

- (UIFont *) textFont {
    return self.font;
}

@end
