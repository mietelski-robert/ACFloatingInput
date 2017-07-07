//
//  ACViewController.m
//  ACFloatingInput
//
//  Created by mietelski-robert on 12/01/2016.
//  Copyright (c) 2016 mietelski-robert. All rights reserved.
//

#import "ACViewController.h"
#import "ACFloatingInput.h"

@interface ACViewController ()<ACFloatingInputDelegate>

@end

@implementation ACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textFloatingInput.type = ACFloatingInputTypeText;
    self.textFloatingInput.text = @"Test";
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0f, 20.0f)];
    imageView.image = [UIImage imageNamed:@"input_password_image"];
    
    self.passwordFloatingInput.type = ACFloatingInputTypePassword;
    self.passwordFloatingInput.textInputView.leftView = imageView;
    
    self.selectionFloatingInput.type = ACFloatingInputTypeSelection;
    self.selectionFloatingInput.borderStyle = ACTextBorderStyleRoundedRect;
    self.selectionFloatingInput.delegate = self;
    
    self.phoneFloatingInput.type = ACFloatingInputTypeText;
    self.phoneFloatingInput.placeholderText = @"Phone";
    self.phoneFloatingInput.inputMask = @"(000) 000-0000;_";
    
    self.multilineFloatingInput.type = ACFloatingInputTypeMultiline;
    self.multilineFloatingInput.borderStyle = ACTextBorderStyleLine;
}

- (void) floatingInputDidSelect:(ACFloatingInput *)textInput {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Select Blue"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Blue"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              textInput.text = @"Blue";
                                                              textInput.validationResult = ACTextValidationResultPassed;
                                                              textInput.errorText = nil;
                                                          });
                                                      }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Orange"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              textInput.text = @"Orange";
                                                              textInput.validationResult = ACTextValidationResultFailed;
                                                              textInput.errorText = @"Error: You should select 'Blue'!";
                                                          });
                                                      }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Green"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              textInput.text = @"Green";
                                                              textInput.validationResult = ACTextValidationResultFailed;
                                                              textInput.errorText = @"Error: You should select 'Blue'!";
                                                          });
                                                      }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
