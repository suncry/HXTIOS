//
//  HXTAddHousePickerView.h
//  ButlerCard
//
//  Created by johnny tang on 4/30/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXTAddHousePickerView;

@protocol HXTAddHousePickerViewDelegate <NSObject>

@optional
- (void)pickerDidSelectHouse:(NSString *)house;
- (void)pickerDidPressCancel;

@end

@interface HXTAddHousePickerView : UIView

@property (assign, nonatomic)id<HXTAddHousePickerViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) NSDictionary *houseList;

- (void)show;
- (void)hide;

@end
