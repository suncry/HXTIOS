//
//  HXTMyProperties.h
//  ButlerCard
//
//  Created by johnny tang on 3/10/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXTPropertyCell.h"

@interface HXTMyProperties : NSObject

@property (strong, nonatomic) NSMutableArray *allHousingEstateNames;
@property (strong, nonatomic) NSMutableArray *properties;

+ (HXTMyProperties *)sharedInstance;
@end
