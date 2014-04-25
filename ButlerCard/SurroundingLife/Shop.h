//
//  Shop.h
//  ButlerCard
//
//  Created by niko on 14-4-25.
//  Copyright (c) 2014年 johnny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Shop : NSManagedObject

@property (nonatomic, retain) NSString * shopID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * iconPath;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSNumber * cansend;
@property (nonatomic, retain) NSNumber * canpayoff;
@property (nonatomic, retain) NSNumber * positionX;
@property (nonatomic, retain) NSNumber * positionY;
@property (nonatomic, retain) NSNumber * grade;
@property (nonatomic, retain) NSString * tel;
@property (nonatomic, retain) NSString * distance;

@end
