//
//  HXTAreaModel.h
//  ButlerCard
//
//  Created by johnny tang on 4/25/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HXTAreaModel;

@protocol HXTAreaModelDelegate <NSObject>
@optional
- (void)areaModel:(HXTAreaModel *)areaModel DidFinishLoadingArea:(NSDictionary *)area;
- (void)areaModel:(HXTAreaModel *)areaModel DidFailLoadingAreaWithError:(NSError *)error;

@end

@interface HXTAreaModel : NSObject

@property (assign, nonatomic) id<HXTAreaModelDelegate> delegate;

@property (strong, nonatomic) NSDictionary *area;

+ (instancetype)sharedInstance;

- (void)loadDataFromServer;
@end
