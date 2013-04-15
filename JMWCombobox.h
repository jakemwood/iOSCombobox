//
//  JMWCombobox.h
//  iOSCombobox
//
//  Created by Jake Wood on 4/14/13.
//  Copyright (c) 2013 Jake Wood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIResponder.h>

@protocol JMWComboboxDelegate;

@interface JMWCombobox : UIControl <UIPickerViewDataSource, UIPickerViewDelegate>
{
    BOOL active;
}

@property (nonatomic, strong) NSArray *values;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSString *currentValue;
@property (nonatomic, strong) id<JMWComboboxDelegate> delegate;

@property (readwrite, strong) UIView *inputView;
@property (readwrite, strong) UIView *inputAccessoryView;

@end

@protocol JMWComboboxDelegate <NSObject>
- (void) comboboxOpened:(JMWCombobox *)combobox;
@end