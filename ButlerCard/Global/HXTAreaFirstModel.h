//
//  HXTAreaFirstModel.h
//  ButlerCard
//
//  Created by johnny tang on 4/25/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class HXTAreaSecModel;

@interface HXTAreaFirstModel : NSManagedObject

@property (nonatomic, retain) NSString * area;
@property (nonatomic, retain) HXTAreaSecModel *areaSecModel;

@end
