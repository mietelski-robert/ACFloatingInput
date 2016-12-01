//
//  ACTextInputLineView.m
//  Pods
//
//  Created by Robert Mietelski on 10.11.2016.
//  Copyright (c) 2016 mietelski-robert. All rights reserved.
//

#import "ACTextInputLineView.h"
#import "UIView+ACFloatingInput.h"

@interface ACTextInputLineView ()

@property (nonatomic, readonly) CAShapeLayer *lineLayer;

@end

@implementation ACTextInputLineView

@synthesize lineLayer = _lineLayer;

@synthesize animationType = _animationType;
@synthesize animationDuration = _animationDuration;
@synthesize defaultColor = _defaultColor;

#pragma mark -
#pragma mark Constructors

- (instancetype) initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _lineLayer = [CAShapeLayer layer];
        _lineLayer.frame = self.bounds;
        _lineLayer.backgroundColor = [UIColor clearColor].CGColor;
        _lineLayer.fillColor = [UIColor clearColor].CGColor;
        _lineLayer.lineWidth = CGRectGetHeight(self.bounds);
        _lineLayer.strokeEnd = 0.0f;
        [self.layer addSublayer:_lineLayer];
        
        self.animationType = ACAnimationTypeLeftToRight;
        self.defaultColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.6f];
        self.animationDuration = 0.4f;
    }
    return self;
}

#pragma mark -
#pragma mark Update frames

- (void) layoutSubviews {
    [super layoutSubviews];
    
    _lineLayer.frame = self.bounds;
    _lineLayer.lineWidth = CGRectGetHeight(self.bounds);
    
    self.lineLayer.path =  [self linePathForAnimationType:self.animationType];
}

#pragma mark -
#pragma mark Access methods

- (void) setAnimationType:(ACAnimationType)other {
    
    // Save property
    _animationType = other;
    
    // Update user interface
    self.lineLayer.path = [self linePathForAnimationType:other];
}

- (void) setDefaultColor:(UIColor *)other {
    
    // Save property
    _defaultColor = other;
    
    // Update user interface
    self.backgroundColor = other;
}

- (void) animateFillLineWithColor:(UIColor *)color {
    
    if (_lineLayer.strokeEnd == 1) {
        if (_lineLayer.strokeColor == nil) {
            self.backgroundColor = _defaultColor;
        }
        else {
            self.backgroundColor = [UIColor colorWithCGColor:_lineLayer.strokeColor];
        }
    }
    _lineLayer.strokeColor = [color CGColor];
    _lineLayer.strokeEnd = 0.0f;
    [self animateLineToValue:1.0f];
}

- (void) animateEmptyLine {
    
    self.backgroundColor = _defaultColor;
    [self animateLineToValue:0.0f];
}

#pragma mark -
#pragma mark Helper methods

- (CGPathRef) linePathForAnimationType:(ACAnimationType)type {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint initialPoint = CGPointMake(0.0f, CGRectGetMidY(self.bounds));
    CGPoint finalPoint = CGPointMake(CGRectGetMaxX(self.bounds), CGRectGetMidY(self.bounds));
    
    switch (type) {
        case ACAnimationTypeLeftToRight:
            
            [path moveToPoint:initialPoint];
            [path addLineToPoint:finalPoint];
            break;
            
        case ACAnimationTypeRightToLeft:
            
            [path moveToPoint:finalPoint];
            [path addLineToPoint:initialPoint];
            break;
            
        default:
            break;
    }
    return [path CGPath];
}

- (void) animateLineToValue:(CGFloat)value {
    
    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [UIView transactionAnimationWithDuration:self.animationDuration
                               timingFuncion:function
                                  animations:^{
                                      self.lineLayer.strokeEnd = value;
                                  }];
}

@end
