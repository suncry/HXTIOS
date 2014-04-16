//
//  HXTPropertyFeeDetailCell.h
//  ButlerCard
//
//  Created by johnny tang on 3/11/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, FeeState) {
    FeeStateNeedToPay = 0, //缴费
    FeeStateProcessing,    //处理中
    FeeStatePaid,          //已缴费
};

@interface HXTPropertyFeeDetailCell : NSObject
@property (assign, nonatomic) NSUInteger year;
@property (assign, nonatomic) NSUInteger month;
@property (assign, nonatomic) float      money;
@property (assign, nonatomic) FeeState  state;
@end
