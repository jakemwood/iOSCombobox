//
//  JMWCombobox.h
//  iOSCombobox
//
//  Created by Jake Wood on 4/14/13.
//  Copyright (c) 2013 Jake Wood. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JMWComboboxDelegate;

@interface JMWCombobox : UIControl <UIPickerViewDataSource, UIPickerViewDelegate>
{
    BOOL active;
}

@property (nonatomic, strong) NSArray *values;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSString *currentValue;
@property (nonatomic, strong) UIView *inputAccessoryView;
@property (nonatomic, strong) id<JMWComboboxDelegate> delegate;

@end

@protocol JMWComboboxDelegate <NSObject>
- (void) beginSelecting:(JMWCombobox *)combobox;
@end