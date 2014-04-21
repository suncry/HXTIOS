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

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButtonItem;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@property (strong, nonatomic) NSArray *starYears;
@property (strong, nonatomic) NSArray *starMonth;
@property (strong, nonatomic) NSArray *endYears;
@property (strong, nonatomic) NSArray *endMonth;
@end

@implementation HXTYearMonthIntervalPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        
        _starYears = @[@"2012", @"2013", @"2014", @"2015"];
        _starMonth = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12"];
        
        _endYears = @[@"2012", @"2013", @"2014", @"2015"];
        _endMonth = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12"];
    }
    return self;
}


#pragma mark - picker view data source

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 5;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numberOfRows = 0;
    switch (component) {
        case 0:
            numberOfRows = _starYears.count;
            break;
        case 1:
            numberOfRows = _starMonth.count;
            break;
        case 2:
            numberOfRows = 0;
            break;
        case 3:
            numberOfRows = _endYears.count;
            break;
        case 4:
            numberOfRows = _endMonth.count;
            break;
            
        default:
            break;
    }

    return numberOfRows;
}

#pragma mark - picker view delegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat width = kWinSize.width / 5;
    switch (component) {
        case 0:
            width = 64;
            break;
        case 1:
            width = 56;
            break;
        case 2:
            width = 32;
            break;
        case 3:
            width = 64;
            break;
        case 4:
            width = 56;
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

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
//    UILabel *label = (UILabel *)view;
//    if (!label) {
//        label = [[UILabel alloc] init];
//        label.backgroundColor = [UIColor redColor];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.font = [UIFont systemFontOfSize:15];
//        label.textColor = [UIColor colorWithRed:84.0f / 255 green:83.0f / 255 blue:83.0f / 255 alpha:1];
//    }
//    
//    switch (component) {
//        case 0:
//            label.text = @"2014 ";
//            break;
//        case 1:
//            label.text = @"12 ";
//            break;
//        case 2:
//            label.text = @" ";
//            break;
//        case 3:
//            label.text = @"2015年";
//            break;
//        case 4:
//            label.text = @" 1 ";
//            break;
//        default:
//            label.text = @"";
//            break;
//    }
//    
//    return label;
//}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = @" ";
    switch (component) {
        case 0:
            title = _starYears[row];
            break;
        case 1:
            title = _starMonth[row];
            break;
        case 2:
            break;
        case 3:
            title = _endYears[row];
            break;
        case 4:
            title = _endMonth[row];
            break;
        default:
            break;
    }
    
    return title;
}



- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"selectRown %lu inComponent %lu", (long)row, (long)component);
    UIView *view = [pickerView viewForRow:row forComponent:component];
    if ([view isKindOfClass:[UILabel class]]) {
//        ((UILabel *)view).textColor = [UIColor blackColor];
//        ((UILabel *)view).font = [UIFont boldSystemFontOfSize:18];
    }
}


#pragma mark - Local Actions

#pragma mark IB Actions
- (IBAction)doneBarButtonItemPressed:(UIBarButtonItem *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(pickerDidPressDoneWithStarYear:andStartMonth:andEndYear:andEndMonth:)]) {
        [_delegate pickerDidPressDoneWithStarYear:2014 andStartMonth:11 andEndYear:2015 andEndMonth:10];
    }
    //    if ([self.delegate respondsToSelector: @selector(pickerDidPressDoneWithMonth:andYear:)])
    //        [self.delegate pickerDidPressDoneWithMonth: _months[_monthIndex]
    //										   andYear: _years[_yearIndex]];
    //    _initialValues = nil;
    //	_year = _years[_yearIndex];
    //    _month = _months[_monthIndex];
}
- (IBAction)cancelBarButtonItemPressed:(UIBarButtonItem *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(pickerDidPressCancel)]) {
        [_delegate pickerDidPressCancel];
    }
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
