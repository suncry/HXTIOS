//
//  HXTAreaModel.h
//  ButlerCard
//
//  Created by johnny tang on 4/25/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXTAreaModel : NSObject

@property (strong, nonatomic) NSMutableArray *areas;
@property (strong, nonatomic) NSMutableArray *towns;

+ (instancetype)sharedInstance;

- (void)show;
@end
