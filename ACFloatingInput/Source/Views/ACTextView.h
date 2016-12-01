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

@end
