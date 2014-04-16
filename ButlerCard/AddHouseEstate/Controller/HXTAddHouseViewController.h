//
//  HXTAddHouseViewController.h
//  ButlerCard
//
//  Created by johnny tang on 3/26/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAddHouseNotification   @"HXTAddHouseNotification"
#define kHouseEstateName        @"houseEstateName"
#define kBuildingNo             @"buildingNo"
#define kUnitNo                 @"unitNo"
#define kHouseNo                @"houseNo"

@class HXTHouse;

@interface HXTAddHouseViewController : UIViewController

@property (strong, nonatomic)HXTHouse *addedHouse;

@end
