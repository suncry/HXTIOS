//
//  HXTYearMonthIntervalPickerView.h
//  ButlerCard
//
//  Created by johnny tang on 4/20/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HXTYearMonthIntervalPickerViewDelegate <NSObject>
@optional
- (void)pickerDidSelectStarYear:(NSUInteger)startYear andStartMonth:(NSUInteger)startMonth andEndYear:(NSUInteger)endYear andEndMonth:(NSUInteger)endMonth;
- (void)pickerDidPressDoneWithStarYear:(NSUInteger)startYear andStartMonth:(NSUInteger)startMonth andEndYear:(NSUInteger)endYear andEndMonth:(NSUInteger)endMonth;
- (void)pickerDidPressCancel;
/**
 *  If you want to change the text field dynamically, as the user changes the values,
 you should implement this method too, so the Cancel button does something.
 *
 *  @param initialValues comes in the form of @{ "month" : month, @"year" : year }
 */
- (void)pickerDidPressCancelWithInitialValues:(NSDictionary *)initialValues;
@end

@interface HXTYearMonthIntervalPickerView : UIControl

@property (nonatomic, strong) id<HXTYearMonthIntervalPickerViewDelegate> delegate;

@end
