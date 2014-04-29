//
//  HXTHouseEstateListModel.h
//  ButlerCard
//
//  Created by johnny tang on 4/29/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HXTHouseEstateListModel;

@protocol HXTHouseEstateListModelDelegate <NSObject>

@optional
- (void)houseEstateListModel:(HXTHouseEstateListModel *)houseEstateListModel DidFinishLoadingListModel:(NSDictionary *)houseEstateList;
- (void)houseEstateListModel:(HXTHouseEstateListModel *)houseEstateListModel DidFailLoadingListModelWithError:(NSError *)error;

@end

@interface HXTHouseEstateListModel : NSObject

@property (assign, nonatomic) id<HXTHouseEstateListModelDelegate> delegate;

- (void)loadDataFromServerWithAreaID:(NSString *)areaID andSearchWord:(NSString *)searchWord;

@end
