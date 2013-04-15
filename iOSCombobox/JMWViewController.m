//
//  JMWViewController.m
//  iOSCombobox
//
//  Created by Jake Wood on 4/13/13.
//  Copyright (c) 2013 Jake Wood. All rights reserved.
//

#import "JMWViewController.h"
#import "JMWCombobox.h"
@interface JMWViewController ()

@end

@implementation JMWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    JMWCombobox *combo = [[JMWCombobox alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 200.f, 32.0f)];
    [combo setValues:@[@"Hello", @"World"]];
    [combo setCurrentValue:@"World"];
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

- (void)beginSelecting:(JMWCombobox *)combobox
{
    [self.keybc setActiveField:combobox];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.keybc setActiveField:textField];
}
@end
