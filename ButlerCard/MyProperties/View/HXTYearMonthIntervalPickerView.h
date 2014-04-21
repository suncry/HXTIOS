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

- (void)pickerDidSelectStartDateComponents:(NSDateComponents *)startComps andEndComponents:(NSDateComponents *)endComps;
- (void)pickerDidPressDoneWithStarDateComponents:(NSDateComponents *)startComps andEndComponents:(NSDateComponents *)endComps;
- (void)pickerDidPressCancelWithStarDateComponents:(NSDateComponents *)startComps andEndComponents:(NSDateComponents *)endComps;
- (void)pickerDidPressCancel;

@end

@interface HXTYearMonthIntervalPickerView : UIControl

@property (strong, nonatomic) id<HXTYearMonthIntervalPickerViewDelegate> delegate;

@property (strong, nonatomic) NSDateComponents *startComps;
@property (strong, nonatomic) NSDateComponents *endComps;
@property (strong, nonatomic) NSDateComponents *defaultStartComps;
@property (strong, nonatomic) NSDateComponents *defaultEndComps;

@end
