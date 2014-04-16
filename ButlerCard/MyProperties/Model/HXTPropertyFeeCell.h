//
//  HXTPropertyFeeCell.h
//  ButlerCard
//
//  Created by johnny tang on 3/10/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, FeeType) {
    FeeTypeNone = 0,                  //未知费用
    FeeTypePropertyManagementFee = 1, //物管费
    FeeTypeParkingFee,                //停车费
    FeeTypeWaterFee,                  //水费
    FeeTypeElectricityFee,            //电费
    FeeTypeGasFrees                   //气费
};

@class HXTPropertyFeeDetailCell;

@interface HXTPropertyFeeCell : NSObject
@property (assign, nonatomic) FeeType freeType;
@property (strong, nonatomic) NSString *commnets;
@property (strong, nonatomic) NSDate *deadline;
@property (assign, nonatomic) BOOL withholding;  //代扣
@property (assign, nonatomic) float money;
@property (strong, nonatomic) NSMutableArray *billDetails;
@end
