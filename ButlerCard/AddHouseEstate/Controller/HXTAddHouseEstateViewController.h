//
//  HXTAddHouseEstateViewController.h
//  ButlerCard
//
//  Created by johnny tang on 2/21/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AddHouseEstateFunctionType) {
    FunctionTypeAddHouseEstate  = 0,      //添加小区
    FunctionTypeBrowHouseEstate          //浏览小区
};

@interface HXTAddHouseEstateViewController : UIViewController

@property (strong, nonatomic) NSNumber *functionType;

@end
