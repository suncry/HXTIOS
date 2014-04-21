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
@property (strong, nonatomic) NSMutableArray *dateArray;

@property (strong, nonatomic) NSDateComponents *curStartComps;
@property (strong, nonatomic) NSDateComponents *curEndComps;

- (NSDate *)dateFromComponents:(NSDateComponents *)comps;
- (NSDateComponents *)componentsFromdate:(NSDate *)date;

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
        
        _dateArray = [NSMutableArray array];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!_startComps) {
        _startComps = [[NSDateComponents alloc] init];
        _startComps.year = 2000;
        _startComps.month = 1;
        _startComps = [self componentsFromdate:[self dateFromComponents:_startComps]];
    }
    
    if (!_endComps) {
        _endComps = [[NSDateComponents alloc] init];
        _endComps.year = 2020;
        _endComps.month = 12;
        _endComps = [self componentsFromdate:[self dateFromComponents:_endComps]];
    }
    
    if (!_defaultStartComps) {
        _defaultStartComps = [_startComps copy];
    } else {
        _defaultStartComps = [self componentsFromdate:[self dateFromComponents:_defaultStartComps]];
    }
    
    if (!_defaultEndComps) {
        _defaultEndComps = [_endComps copy];
    } else {
        _defaultEndComps   = [self componentsFromdate:[self dateFromComponents:_defaultEndComps]];
    }
    
    _curStartComps = [_defaultStartComps copy];
    _curEndComps = [_defaultEndComps copy];
    
    NSLog(@"_defaultEndComps = %@ _defaultEndComps.date = %@", _defaultEndComps, [self dateFromComponents:_defaultStartComps]);
    
    NSDate *startDate = [self dateFromComponents:_startComps];
    NSDate *endDate = [self dateFromComponents:_endComps];
    
    for (NSDate *date = [startDate copy]; [date compare:endDate] == NSOrderedAscending || [date compare:endDate] == NSOrderedSame; date = [NSDate dateWithTimeInterval:24 * 60 *60 sinceDate:date ]) {
        NSLog(@"myDate1 = %@",[date descriptionWithLocale:[[NSLocale alloc] initWithLocaleIdentifier : @"zh_CN" ]]);
        
        [_dateArray addObject:date];
    }
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


#pragma mark - Local Functions

- (NSDate *)dateFromComponents:(NSDateComponents *)comps {
    NSCalendar *myCal = [NSCalendar currentCalendar];
    [myCal setTimeZone:[NSTimeZone systemTimeZone]];
    NSLog(@"myDate1 = %@", [myCal dateFromComponents:comps]);
    NSLog(@"myDate1 = %@",[[myCal dateFromComponents:comps] descriptionWithLocale:[[NSLocale alloc] initWithLocaleIdentifier : @"zh_CN" ]]);
    return  [myCal dateFromComponents:comps];
}

- (NSDateComponents *)componentsFromdate:(NSDate *)date {
    NSCalendar *myCal = [NSCalendar currentCalendar];
    [myCal setTimeZone:[NSTimeZone systemTimeZone]];
    return [myCal components:kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay fromDate:date];
}

#pragma mark IB Actions
- (IBAction)doneBarButtonItemPressed:(UIBarButtonItem *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(pickerDidPressDoneWithStarDateComponents:andEndComponents:)]) {
        [_delegate pickerDidPressDoneWithStarDateComponents:_curStartComps andEndComponents:_curEndComps];
    }
}
- (IBAction)cancelBarButtonItemPressed:(UIBarButtonItem *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(pickerDidPressCancel)]) {
        [_delegate pickerDidPressCancel];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(pickerDidPressCancelWithStarDateComponents:andEndComponents:)]) {
        [_delegate pickerDidPressCancelWithStarDateComponents:_defaultStartComps andEndComponents:_defaultEndComps];
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
