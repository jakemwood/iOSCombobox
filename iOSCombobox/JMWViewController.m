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
    
    [self setKeyboardC:[[BSKeyboardControls alloc] initWithFields:@[combo, self.textField]]];
    [[self keyboardC] setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardControlsDonePressed:(BSKeyboardControls *)keyboardControls
{
    [keyboardControls.activeField resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"Text field did begin editign!");
    
    [self.keyboardC setActiveField:textField];
}

- (void)beginSelecting:(JMWCombobox *)combobox
{
    [self.keyboardC setActiveField:combobox];
}

@end
