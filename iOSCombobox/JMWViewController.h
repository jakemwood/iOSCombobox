//
//  JMWViewController.h
//  iOSCombobox
//
//  Created by Jake Wood on 4/13/13.
//  Copyright (c) 2013 Jake Wood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSKeyboardControls.h"
#import "JMWCombobox.h"

@interface JMWViewController : UIViewController <BSKeyboardControlsDelegate, UITextFieldDelegate, JMWComboboxDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) BSKeyboardControls *keyboardC;
@end
