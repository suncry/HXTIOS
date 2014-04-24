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
@property (strong, nonatomic) UIControl *coverView;
@property (assign, nonatomic) BOOL isShowing;

@property (strong, nonatomic) NSArray *starYears;
@property (strong, nonatomic) NSArray *starMonth;
@property (strong, nonatomic) NSArray *endYears;
@property (strong, nonatomic) NSArray *endMonth;
@property (strong, nonatomic) NSMutableArray *dateArray;
@property (strong, nonatomic) NSMutableArray *compsArray;

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

- (void)_setup {
    _starYears = @[@"2012", @"2013", @"2014", @"2015"];
    _starMonth = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12"];
    
    _endYears = @[@"2012", @"2013", @"2014", @"2015"];
    _endMonth = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12"];
    
    _dateArray = [NSMutableArray array];
    _compsArray = [NSMutableArray array];
    
    self.frame = CGRectMake(0, kWinSize.height, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    _coverView = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [_coverView addTarget:self action:@selector(backgroundTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    _coverView.userInteractionEnabled = NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!_isShowing) {
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
        
        //    NSLog(@"_defaultEndComps = %@ _defaultEndComps.date = %@", _defaultEndComps, [self dateFromComponents:_defaultStartComps]);
        
        for (NSDateComponents *comps = [_startComps copy]; [[self dateFromComponents:comps] compare:[self dateFromComponents:_endComps]] == NSOrderedAscending || [[self dateFromComponents:comps] compare:[self dateFromComponents:_endComps]] == NSOrderedSame; comps.month++) {
            if (comps.month > 12) {
                comps.year++;
                comps.month = 1;
            }
            
            [_dateArray addObject:[NSString stringWithFormat:@"%4lu年%2lu月", (long)comps.year, (long)comps.month]];
            [_compsArray addObject:[comps copy]];
            
            if ([[self dateFromComponents:_defaultStartComps] compare:[self dateFromComponents:comps]] == NSOrderedSame) {
                _defaultStartComps = [_compsArray lastObject];
            }
            
            if ([[self dateFromComponents:_defaultEndComps] compare:[self dateFromComponents:comps]] == NSOrderedSame) {
                _defaultEndComps = [_compsArray lastObject];
            }
        }
        
        [_picker reloadAllComponents];
        [_picker selectRow:[_compsArray indexOfObject:_defaultStartComps] inComponent:0 animated:NO];
        [_picker selectRow:[_compsArray indexOfObject:_defaultEndComps] inComponent:2 animated:NO];
    }
}

#pragma mark - picker view data source

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numberOfRows = 0;
    switch (component) {
        case 0:
            numberOfRows = _dateArray.count;
            break;
        case 1:
            numberOfRows = 0;
            break;
        case 2:
            numberOfRows = _dateArray.count;
            break;
            
        default:
            break;
    }

    return numberOfRows;
}

#pragma mark - picker view delegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat width = 0;
    switch (component) {
        case 0:
            width = 134;
            break;
        case 1:
            width = 20;
            break;
        case 2:
            width = 134;
            break;
        default:
            break;
    }
    
    return width;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = @"";
    switch (component) {
        case 0:
            title = _dateArray[row];
            break;
        case 1:
            break;
        case 2:
            title = _dateArray[row];
            break;
        default:
            break;
    }
    
    return title;
}



- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        _curStartComps = _compsArray[row];
    }else if (component == 2) {
        _curEndComps = _compsArray[row];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(pickerDidSelectStartDateComponents:andEndComponents:)]) {
        [_delegate pickerDidSelectStartDateComponents:_curStartComps andEndComponents:_curEndComps];
    }
}


#pragma mark - local functions

- (NSDate *)dateFromComponents:(NSDateComponents *)comps {
    NSCalendar *myCal = [NSCalendar currentCalendar];
    [myCal setTimeZone:[NSTimeZone systemTimeZone]];
//    NSLog(@"myDate1 = %@", [myCal dateFromComponents:comps]);
//    NSLog(@"myDate1 = %@",[[myCal dateFromComponents:comps] descriptionWithLocale:[[NSLocale alloc] initWithLocaleIdentifier : @"zh_CN" ]]);
    return  [myCal dateFromComponents:comps];
}

- (NSDateComponents *)componentsFromdate:(NSDate *)date {
    NSCalendar *myCal = [NSCalendar currentCalendar];
    [myCal setTimeZone:[NSTimeZone systemTimeZone]];
    return [myCal components:kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay fromDate:date];
}

- (void)backgroundTouchUpInside {
    [self hide];

    if (_delegate && [_delegate respondsToSelector:@selector(pickerDidPressCancelWithStarDateComponents:andEndComponents:)]) {
        [_delegate pickerDidPressCancelWithStarDateComponents:_defaultStartComps andEndComponents:_defaultEndComps];
    }
}

#pragma mark IB Actions

- (IBAction)doneBarButtonItemPressed:(UIBarButtonItem *)sender {
    [self hide];
    if (_delegate && [_delegate respondsToSelector:@selector(pickerDidPressDoneWithStarDateComponents:andEndComponents:)]) {
        [_delegate pickerDidPressDoneWithStarDateComponents:_curStartComps andEndComponents:_curEndComps];
    }
}
- (IBAction)cancelBarButtonItemPressed:(UIBarButtonItem *)sender {
    [self hide];
    if (_delegate && [_delegate respondsToSelector:@selector(pickerDidPressCancel)]) {
        [_delegate pickerDidPressCancel];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(pickerDidPressCancelWithStarDateComponents:andEndComponents:)]) {
        [_delegate pickerDidPressCancelWithStarDateComponents:_defaultStartComps andEndComponents:_defaultEndComps];
    }
}

#pragma mark - public functions

- (void)show {
    [[UIApplication sharedApplication].windows.lastObject addSubview:_coverView];
    [[UIApplication sharedApplication].windows.lastObject addSubview:self];
    
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionTransitionFlipFromBottom
                     animations:^{
                         self.frame = CGRectMake(0, kWinSize.height - CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
                     }
                     completion:^(BOOL finished){
                         _coverView.userInteractionEnabled = YES;
                         _isShowing = YES;
                     }];
}

- (void)hide {
    [_coverView removeFromSuperview];
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionTransitionFlipFromBottom
                     animations:^{
                         self.frame = CGRectMake(0, kWinSize.height, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         _coverView.userInteractionEnabled = NO;
                         _isShowing = NO;
                     }];
}

@end
