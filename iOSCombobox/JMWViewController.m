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
    [self.view addSubview:combo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
