//
//  ACLoginViewController.m
//  ACFloatingInput
//
//  Created by Robert Mietelski on 13.12.2016.
//  Copyright © 2016 mietelski-robert. All rights reserved.
//

#import "ACLoginViewController.h"

#import <ACFloatingInput/ACFloatingInput.h>
#import <ACFloatingInput/NSString+ACFloatingInput.h>

@interface ACLoginViewController ()<ACFloatingInputDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet ACFloatingInput *usernameFloatingInput;
@property (weak, nonatomic) IBOutlet ACFloatingInput *passwordFloatingInput;

@end

@implementation ACLoginViewController

#pragma mark -
#pragma mark Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.usernameFloatingInput.type = ACFloatingInputTypeText;
    self.usernameFloatingInput.hintText = @"Username";
    self.usernameFloatingInput.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.usernameFloatingInput.autocorrectionType = UITextAutocorrectionTypeNo;
    self.usernameFloatingInput.keyboardType = UIKeyboardTypeEmailAddress;
    self.usernameFloatingInput.returnKeyType = UIReturnKeyNext;
    self.usernameFloatingInput.text = self.username;
    self.usernameFloatingInput.delegate = self;
    
    self.passwordFloatingInput.type = ACFloatingInputTypePassword;
    self.passwordFloatingInput.hintText = @"Password";
    self.passwordFloatingInput.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.passwordFloatingInput.autocorrectionType = UITextAutocorrectionTypeNo;
    self.passwordFloatingInput.returnKeyType = UIReturnKeyDone;
    self.passwordFloatingInput.text = self.password;
    self.passwordFloatingInput.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self registerNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self unregisterNotifications];
}

#pragma mark -
#pragma mark Access methods

- (void) setUsername:(NSString *)other {
    
    // Save property
    _username = other;
    
    // Update user interface
    if ([self isViewLoaded]) {
        self.usernameFloatingInput.text = other;
    }
}

- (void) setPassword:(NSString *)other {
    
    // Save property
    _password = other;
    
    // Update user interface
    if ([self isViewLoaded]) {
        self.passwordFloatingInput.text = other;
    }
}

#pragma mark -
#pragma mark Actions

- (IBAction)submitAction:(UIButton *)sender {
    
    // Validation
    NSArray *inputs = @[self.usernameFloatingInput, self.passwordFloatingInput];
    NSArray *errors = [NSArray array];
    
    for (ACFloatingInput *textInput in inputs) {
        NSString *errorText = [self validateTextInput:textInput];
        
        if (![NSString isEmpty:errorText]) {
            errors = [NSArray arrayWithObject:errorText];
            
            textInput.validationResult = ACTextValidationResultFailed;
            [textInput shake];
        }
        else {
            textInput.validationResult = ACTextValidationResultPassed;
        }
        textInput.errorText = errorText;
    }
    
    if (errors.count == 0) {
    
    }
}

#pragma mark -
#pragma mark Implementation of the protocol ACFloatingInputDelegate

- (BOOL) floatingInputShouldBeginEditing:(ACFloatingInput *)textInput {
    
    NSMutableArray *items = [NSMutableArray array];
    UIToolbar *keyboardToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, 36.0f)];
    keyboardToolBar.barStyle = UIBarStyleDefault;
    
    if (self.usernameFloatingInput == textInput) {
        
        UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                           style:UIBarButtonItemStyleDone
                                                                          target:textInput
                                                                          action:@selector(resignFirstResponder)];
        [items addObject:leftButtonItem];
    }
    else if (self.passwordFloatingInput == textInput) {
        
        UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                        target:nil
                                                                                        action:nil];
        [items addObject:leftButtonItem];
        
        UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Previous"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self.usernameFloatingInput
                                                                           action:@selector(becomeFirstResponder)];
        [items addObject:rightButtonItem];
    }
    keyboardToolBar.items = items;
    textInput.inputAccessoryView = keyboardToolBar;
    
    return YES;
}

- (void) floatingInputDidEndEditing:(ACFloatingInput *)textInput {
    NSString *errorText = [self validateTextInput:textInput];
    
    if ([NSString isEmpty:errorText]) {
        textInput.validationResult = ACTextValidationResultPassed;
    }
    else {
        textInput.validationResult = ACTextValidationResultFailed;
    }
    textInput.errorText = errorText;
}

- (void) floatingInputDidChange:(ACFloatingInput *)textInput {
    
    if (self.usernameFloatingInput == textInput) {
        _username = [textInput.text copy];
    }
    else if (self.passwordFloatingInput == textInput) {
        _password = [textInput.text copy];
    }
}

- (BOOL) floatingInputShouldReturn:(ACFloatingInput *)textInput {
    
    if (self.usernameFloatingInput == textInput) {
        [self.passwordFloatingInput becomeFirstResponder];
    }
    else {
        [textInput resignFirstResponder];
    }
    return YES;
}

#pragma mark -
#pragma mark Validation

- (NSString *) validateTextInput:(ACFloatingInput *)textInput {
    
    if (textInput == self.usernameFloatingInput) {
        if ([NSString isEmpty:textInput.text]) {
            return [NSString stringWithFormat:@"%@ is required!", textInput.hintText];
        }
        else {
            NSString *textByTrimmingWhiteCharacters = [textInput.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            if ([NSString isEmpty:textByTrimmingWhiteCharacters]) {
                return [NSString stringWithFormat:@"%@ is invalid!", textInput.hintText];
            }
        }
    }
    else if (textInput == self.passwordFloatingInput) {
        if ([NSString isEmpty:textInput.text]) {
            return [NSString stringWithFormat:@"%@ is required!", textInput.hintText];
        }
    }
    return nil;
}

#pragma mark -
#pragma mark Notifications

- (void)registerNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChangeFrame:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
}

- (void)unregisterNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidChangeFrameNotification
                                                  object:nil];
}

- (void)keyboardWasShown:(NSNotification *)notification {
    
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    self.scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
}

- (void)keyboardDidHide:(NSNotification *)notification {
    self.scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
}

- (void)keyboardDidChangeFrame:(NSNotification *)notification {
    
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    self.scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
}

@end
