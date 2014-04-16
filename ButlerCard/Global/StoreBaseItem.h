//
//  StoreBaseItem.h
//  ButlerCard
//
//  Created by niko on 14-3-26.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger
{
    STOREDATA_USERINFO = 1, //用户信息(用户名、密码、账户类型等)
    STOREDATA_SETTING,      //用户设置数据
    STOREDATA_HOMEPAGE      //首页数据
} StoreDataType;

@interface StoreBaseItem : NSObject

@property (atomic, assign) StoreDataType itemID;//数据库中的ID
@property (atomic, copy) NSString *key;

@end
