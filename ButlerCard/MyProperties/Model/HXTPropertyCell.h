//
//  HXTPropertyCell.h
//  ButlerCard
//
//  Created by johnny tang on 3/10/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXTHouse.h"
#import "HXTPropertyFeeCell.h"


@interface HXTPropertyCell : NSObject
@property (strong, nonatomic) HXTHouse     *house;
@property (strong, nonatomic) NSMutableArray *fees;
@end
