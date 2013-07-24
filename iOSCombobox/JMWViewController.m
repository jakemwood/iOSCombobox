//
//  JMWViewController.m
//  iOSCombobox
//
//  Created by Jake Wood on 4/13/13.
//  Copyright (c) 2013 Jake Wood. All rights reserved.  MIT Licensed,
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "JMWViewController.h"
#import "iOSCombobox.h"
@interface JMWViewController ()

@end

@implementation JMWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    iOSCombobox *combo = [[iOSCombobox alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 200.f, 44.0f)];
    [combo setValues:@[@"Hello", @"World"]];
    [combo setCurrentValue:@"World"];
    [combo setDelegate:self];
    [self.view addSubview:combo];
    
    [self setKeybc:[[BSKeyboardControls alloc] initWithFields:@[combo, self.randomText]]];
    [self.keybc setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardControlsDonePressed:(BSKeyboardControls *)keyboardControls
{
    [[keyboardControls activeField] resignFirstResponder];
}

- (void)comboboxOpened:(iOSCombobox *)combobox
{
    [self.keybc setActiveField:combobox];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.keybc setActiveField:textField];
}
@end
