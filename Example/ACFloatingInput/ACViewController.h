//
//  ACViewController.h
//  ACFloatingInput
//
//  Created by mietelski-robert on 12/01/2016.
//  Copyright (c) 2016 mietelski-robert. All rights reserved.
//

@import UIKit;

@class ACFloatingInput;

@interface ACViewController : UIViewController

@property (weak, nonatomic) IBOutlet ACFloatingInput *textFloatingInput;
@property (weak, nonatomic) IBOutlet ACFloatingInput *passwordFloatingInput;
@property (weak, nonatomic) IBOutlet ACFloatingInput *selectionFloatingInput;
@property (weak, nonatomic) IBOutlet ACFloatingInput *phoneFloatingInput;
@property (weak, nonatomic) IBOutlet ACFloatingInput *multilineFloatingInput;

@end
