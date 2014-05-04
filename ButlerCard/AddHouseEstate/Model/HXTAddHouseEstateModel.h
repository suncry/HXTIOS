//
//  HXTAddHouseEstateModel.h
//  ButlerCard
//
//  Created by johnny tang on 5/4/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HXTAddHouseEstateModel;

@protocol HXTAddHouseEstateModelDelegate <NSObject>

@optional
- (void)addHouseEstateModel:(HXTAddHouseEstateModel *)addHouseEstateModel DidFinishAddHouseEstate:(NSDictionary *)houseEstate;
- (void)addHouseEstateModel:(HXTAddHouseEstateModel *)addHouseEstateModel DidFailAddHouseEstateWithError:(NSError *)error;

@end

@interface HXTAddHouseEstateModel : NSObject

@property (assign, nonatomic) id<HXTAddHouseEstateModelDelegate> delegate;

- (void)addHouseEstateToServerWithUserID:(NSString *)userID houseEstateID:(NSString *)houseEstateID buildingNo:(NSString *)buildingNo unitNo:(NSString *)unitNo houseNo:(NSString *)houseNo;

@end
