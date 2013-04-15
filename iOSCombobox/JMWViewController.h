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

@interface JMWViewController : UIViewController <BSKeyboardControlsDelegate, JMWComboboxDelegate, UITextFieldDelegate>

@property (nonatomic, strong) BSKeyboardControls *keybc;
@property (strong, nonatomic) IBOutlet UITextField *randomText;
@end
