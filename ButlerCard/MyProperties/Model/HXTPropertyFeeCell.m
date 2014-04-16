//
//  HXTPropertyFeeCell.m
//  ButlerCard
//
//  Created by johnny tang on 3/10/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTPropertyFeeCell.h"
#import "HXTPropertyFeeDetailCell.h"

@interface HXTPropertyFeeCell ()

@end

@implementation HXTPropertyFeeCell

- (id)init {
    self = [super init];
    if (self) {
        _freeType = FeeTypeNone;
        _deadline = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        _money = 100;
        _billDetails = [[NSMutableArray alloc] initWithCapacity:2];
        for (NSUInteger i = 0; i < 2; i++) {
            for (NSUInteger j = 1; j <= 12; j ++) {
                HXTPropertyFeeDetailCell *billDetailCell = [[HXTPropertyFeeDetailCell alloc] init];
                billDetailCell.year = 2013;
                billDetailCell.month = i;
                billDetailCell.money = 210;
                billDetailCell.state = FeeStateNeedToPay;
            }
        }
    }
    return self;
}
@end
