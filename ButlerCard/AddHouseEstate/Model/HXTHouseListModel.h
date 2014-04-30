//
//  HXTHouseListModel.h
//  ButlerCard
//
//  Created by johnny tang on 4/30/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HXTHouseListModel;

@protocol HXTHouseListModelDelegate <NSObject>
@optional
- (void)houseListModel:(HXTHouseListModel *)houseListModel DidFinishLoadingListModel:(NSDictionary *)houseList;
- (void)houseListModel:(HXTHouseListModel *)houseListModel DidFailLoadingListModelWithError:(NSError *)error;
@end

@interface HXTHouseListModel : NSObject

@property (assign, nonatomic) id<HXTHouseListModelDelegate> delegate;

- (void)loadDataFromServerWithHouseEstateID:(NSString *)houseEstateID;

@end
