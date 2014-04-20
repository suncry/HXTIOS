//
//  HXTYearMonthIntervalPickerView.m
//  ButlerCard
//
//  Created by johnny tang on 4/20/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import "HXTYearMonthIntervalPickerView.h"

#define kWinSize [UIScreen mainScreen].bounds.size

@interface HXTYearMonthIntervalPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *picker;

@end

@implementation HXTYearMonthIntervalPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self _setup];
    }
    return self;
}

#pragma mark - Init

- (void)_setup {
    self.frame = CGRectMake(0.0, 0.0, kWinSize.width, 260.0);
    self.backgroundColor = [UIColor whiteColor];
    CGRect datePickerFrame = CGRectMake(0.0, 44.5, self.frame.size.width, 216.0);
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame: CGRectMake(0.0, 0.0, self.frame.size.width, datePickerFrame.origin.y - 0.5)];
    toolbar.barTintColor = [UIColor whiteColor];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                     initWithBarButtonSystemItem: UIBarButtonSystemItemCancel
                                     target: self
                                     action: @selector(_cancel)];
    cancelButton.tintColor = [UIColor redColor];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
                                  target: self
                                  action: nil];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem: UIBarButtonSystemItemDone
                                target: self
                                action: @selector(_done)];
    
    doneBtn.tintColor = [UIColor colorWithRed:40.0f / 255 green:175.0f / 233 blue:3.0f / 255 alpha:1];
    [toolbar setItems: @[cancelButton, flexSpace, doneBtn]
             animated: YES];
    [self addSubview: toolbar];
    
    _picker = [[UIPickerView alloc] initWithFrame: datePickerFrame];
    _picker.showsSelectionIndicator = YES;
    _picker.dataSource = self;
    _picker.delegate = self;
    [self addSubview: _picker];
}

#pragma mark - picker view data source

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 5;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 2) {
        return 1;
    }
    return 10;
}

#pragma mark - picker view delegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat width = kWinSize.width / 5;
    switch (component) {
        case 0:
        case 4:
            width = 62;
            break;
        case 2:
            width = 40;
            break;
        case 1:
        case 3:
            width = 62;
            break;
            
        default:
            width = 0;
            break;
    }
    
    return width;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = (UILabel *)view;
    if (!label) {
        label = [[UILabel alloc] init];
        if (component == 2) {
            label.frame = CGRectMake(0, 0, 40.0f, 30.f);
        } else {
            label.frame = CGRectMake(0, 0, 62.0f, 30.f);
        }
        label.backgroundColor = [UIColor redColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithRed:84.0f / 255 green:83.0f / 255 blue:83.0f / 255 alpha:1];
    }
    
    switch (component) {
        case 0:
            label.text = @"2014年";
            break;
        case 1:
            label.text = @"12月";
            break;
        case 2:
            label.text = @"到";
            break;
        case 3:
            label.text = @"2015年";
            break;
        case 4:
            label.text = @"11月";
            break;
        default:
            label.text = @"";
            break;
    }
    
    return label;
}
 

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"selectRown %lu inComponent %lu", (long)row, (long)component);
}


#pragma mark - Local Actions

- (void)_done {
//    if ([self.delegate respondsToSelector: @selector(pickerDidPressDoneWithMonth:andYear:)])
//        [self.delegate pickerDidPressDoneWithMonth: _months[_monthIndex]
//										   andYear: _years[_yearIndex]];
//    _initialValues = nil;
//	_year = _years[_yearIndex];
//    _month = _months[_monthIndex];
}


- (void)_cancel {
//    if (!_initialValues) _initialValues  = @{ @"month" : _months[_monthIndex],
//											  @"year" : _years[_yearIndex] };
//    if ([self.delegate respondsToSelector: @selector(pickerDidPressCancelWithInitialValues:)]) {
//        [self.delegate pickerDidPressCancelWithInitialValues: _initialValues];
//        [self.datePicker selectRow: [_months indexOfObject: _initialValues[@"month"]]
//                       inComponent: 0
//                          animated: NO];
//        [self.datePicker selectRow: [_years indexOfObject: _initialValues[@"year"]]
//                       inComponent: 1
//                          animated: NO];
//    }
//    else if ([self.delegate respondsToSelector: @selector(pickerDidPressCancel)])
//        [self.delegate pickerDidPressCancel];
//	_monthIndex = [_months indexOfObject: _initialValues[@"month"]];
//	_yearIndex = [_years indexOfObject: _initialValues[@"year"]];
//	_year = _years[_yearIndex];
//    _month = _months[_monthIndex];
//	_initialValues = nil;
}
@end
