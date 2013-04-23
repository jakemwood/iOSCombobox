//
//  iOSCombobox.h
//  iOSCombobox
//
//  Created by Jake Wood on 4/14/13.
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

#import <UIKit/UIKit.h>
#import <UIKit/UIResponder.h>

@protocol iOSComboboxDelegate;

@interface iOSCombobox : UIControl <UIPickerViewDataSource, UIPickerViewDelegate>
{
    BOOL active;
}

@property (nonatomic, strong) NSArray *values;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSString *currentValue;
@property (nonatomic, strong) id<iOSComboboxDelegate> delegate;

@property (readwrite, strong) UIView *inputView;
@property (readwrite, strong) UIView *inputAccessoryView;

@end

@protocol iOSComboboxDelegate <NSObject>
@optional
- (void) comboboxOpened:(iOSCombobox *)combobox;
- (void) comboboxChanged:(iOSCombobox *)combobox toValue:(NSString *)toValue;
@end