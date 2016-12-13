//
//  ACTextInputView.m
//  Pods
//
//  Created by Robert Mietelski on 10.11.2016.
//  Copyright (c) 2016 mietelski-robert. All rights reserved.
//

#import "ACTextInputView.h"

@interface ACTextInputView ()

@property (nonatomic, strong) NSLayoutConstraint *textInputViewLeadingConstraint;
@property (nonatomic, strong) NSLayoutConstraint *textInputViewTrailingConstraint;

@end

@implementation ACTextInputView

@synthesize leftView = _leftView;
@synthesize inputView = _inputView;
@synthesize rightView = _rightView;

@synthesize textInputViewLeadingConstraint = _textInputViewLeadingConstraint;
@synthesize textInputViewTrailingConstraint = _textInputViewTrailingConstraint;

#pragma mark -
#pragma mark Constructors

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

#pragma mark -
#pragma mark Access methods

- (void) setLeftView:(UIView *)other {
    [_leftView removeFromSuperview];
    
    // Save property
    _leftView = other;
    
    // Update user interface
    if (other != nil) {
        
        other.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:other];
        
        [NSLayoutConstraint constraintWithItem:other
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:other.bounds.size.width].active = YES;
        
        [NSLayoutConstraint constraintWithItem:other
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:other.bounds.size.height].active = YES;
        
        [NSLayoutConstraint constraintWithItem:other
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1.0
                                      constant:0.0f].active = YES;
        
        [NSLayoutConstraint constraintWithItem:other
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1.0
                                      constant:0.0f].active = YES;
    }
    [self setNeedsUpdateConstraints];
}

- (void) setInputView:(UIView<ACTextInput> *)other {
    [_inputView removeFromSuperview];
    
    // Save property
    _inputView = other;
    
    // Update user interface
    if (other != nil) {
        
        other.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:other];
        
        [NSLayoutConstraint constraintWithItem:other
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1.0
                                      constant:0.0f].active = YES;
        
        [NSLayoutConstraint constraintWithItem:other
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1.0
                                      constant:0.0f].active = YES;
    }
    [self setNeedsUpdateConstraints];
}

- (void) setRightView:(UIView *)other {
    [_rightView removeFromSuperview];
    
    // Save property
    _rightView = other;
    
    // Update user interface
    if (other != nil) {
        
        other.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:other];
        
        [NSLayoutConstraint constraintWithItem:other
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:other.bounds.size.width].active = YES;
        
        [NSLayoutConstraint constraintWithItem:other
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:other.bounds.size.height].active = YES;
        
        [NSLayoutConstraint constraintWithItem:other
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1.0
                                      constant:0.0f].active = YES;
        
        [NSLayoutConstraint constraintWithItem:other
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1.0
                                      constant:0.0f].active = YES;
    }
    [self setNeedsUpdateConstraints];
}

- (void) setTextInputViewLeadingConstraint:(NSLayoutConstraint *)other {
    
    // Update user interface
    [self removeConstraint:_textInputViewLeadingConstraint];
    
    // Save property
    _textInputViewLeadingConstraint = other;
}

- (void) setTextInputViewTrailingConstraint:(NSLayoutConstraint *)other {
    
    // Update user interface
    [self removeConstraint:_textInputViewTrailingConstraint];
    
    // Save property
    _textInputViewTrailingConstraint = other;
}

#pragma mark -
#pragma mark Update constraints

- (void) updateConstraints {
    
    if (self.inputView != nil) {
        if (self.leftView != nil) {
            self.textInputViewLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.inputView
                                                                               attribute:NSLayoutAttributeLeading
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.leftView
                                                                               attribute:NSLayoutAttributeTrailing
                                                                              multiplier:1.0
                                                                                constant:5.0f];
        }
        else {
            self.textInputViewLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.inputView
                                                                               attribute:NSLayoutAttributeLeading
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self
                                                                               attribute:NSLayoutAttributeLeading
                                                                              multiplier:1.0
                                                                                constant:0.0f];
        }
        self.textInputViewLeadingConstraint.active = YES;
        
        if (self.rightView != nil) {
            self.textInputViewTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.rightView
                                                                                attribute:NSLayoutAttributeLeading
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self.inputView
                                                                                attribute:NSLayoutAttributeTrailing
                                                                               multiplier:1.0
                                                                                 constant:5.0f];
        }
        else {
            self.textInputViewTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.inputView
                                                                                attribute:NSLayoutAttributeTrailing
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self
                                                                                attribute:NSLayoutAttributeTrailing
                                                                               multiplier:1.0
                                                                                 constant:0.0f];
        }
        self.textInputViewTrailingConstraint.active = YES;
    }
    [super updateConstraints];
}

@end
