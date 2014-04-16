//
//  SqliteStoreManager.h
//  ButlerCard
//
//  Created by niko on 14-3-26.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface SqliteStoreManager : NSObject
{
    FMDatabase *mdatabase;
}

+ (SqliteStoreManager*)GetInstance;

/*********************************************************
 -----className待取出数据集合的类名称
 -----返回的是该类型的所有存储的数据
 ********************************************************/
- (NSArray*)GetSoreDatasWithType:(const char *)className;

/*********************************************************
 -----datas是存储到数据库中的数据集合，要求NSArray中的元素是同一类型
 -----breplace，YES表示清空之前存储的数据
 ********************************************************/
- (void)StoreDatasWithArray:(NSArray*)datas breplace:(BOOL)breplace;

@end
