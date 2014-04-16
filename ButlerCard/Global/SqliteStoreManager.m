//
//  SqliteStoreManager.m
//  ButlerCard
//
//  Created by niko on 14-3-26.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import "SqliteStoreManager.h"
#import <objc/runtime.h>

@implementation SqliteStoreManager

+ (SqliteStoreManager*)GetInstance
{
    static SqliteStoreManager *manager = nil;
    if(manager == nil)
    {
        manager = [[SqliteStoreManager alloc] init];
        NSString *docsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *dbPath   = [docsPath stringByAppendingPathComponent:@"system.db"];
        manager->mdatabase = [FMDatabase databaseWithPath:dbPath];
        [manager->mdatabase open];
    }
    return manager;
}

- (void)dealloc
{
    [mdatabase close];
}

- (NSArray*)GetSoreDatasWithType:(const char *)className
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    Class class = objc_getClass(className);
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList(class,&outCount);
    const char *pName = NULL;
    NSString *key = nil;
    NSMutableArray *allkeys = [[NSMutableArray alloc] init];
    for(int i = 0;i < outCount;i++)
    {
        pName = property_getName(properties[i]);
        key = [NSString stringWithCString:pName encoding:NSUTF8StringEncoding];
        [allkeys addObject:key];
    }
    free(properties);
    
    key = [NSString stringWithUTF8String:className];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@", key];
    FMResultSet *ars = [mdatabase executeQuery:sql];
    
    outCount = (unsigned int)allkeys.count;
    while ([ars next])
    {
        NSObject *classobj = [[NSClassFromString(key) alloc] init];
        for(int i = 0;i < outCount;i++)
        {
            [classobj setValue:[ars stringForColumn:allkeys[i]] forKey:allkeys[i]];
        }
        [results addObject:classobj];
    }
    
    return results;
}

- (void)StoreDatasWithArray:(NSArray*)datas breplace:(BOOL)breplace
{
    if(datas.count <= 0)return;
    
    BOOL needCheckCreate = YES;
    NSMutableDictionary *classFields = [[NSMutableDictionary alloc] init];
    NSMutableString *sql = nil;
    NSMutableString *keys = [[NSMutableString alloc] init];
    NSMutableString *values = [[NSMutableString alloc] init];
    NSString *tableName = nil;
    unsigned int outCount = 0;
    for (NSObject *wItem in datas)
    {
        Class class = [wItem class];
        if(needCheckCreate)//是否需要检查数据表存在
        {
            needCheckCreate = NO;
            objc_property_t *properties = class_copyPropertyList(class,&outCount);
            const char *pName = NULL;
            NSString *key = nil, *value = nil;
            tableName = [NSString stringWithUTF8String:class_getName(class)];//object_getClassName
            sql = [NSMutableString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(id INTEGER DEFAULT 1 NOT NULL PRIMARY KEY AUTOINCREMENT", tableName];
            for(int i = 0;i < outCount;i++)
            {
                pName = property_getName(properties[i]);
                key = [NSString stringWithCString:pName encoding:NSUTF8StringEncoding];
                pName = property_getAttributes(properties[i]);
                value = [[NSString stringWithCString:pName encoding:NSUTF8StringEncoding] lowercaseString];
                if ([value hasPrefix:@"ti"] || [value hasPrefix:@"tl"] || [value hasPrefix:@"tc"] || [value hasPrefix:@"ts"])//int、long、char、short
                {
                    value = @"INTEGER";
                }
                else if ([value hasPrefix:@"Tf"] || [value hasPrefix:@"Td"])//float、double
                {
                    value = @"FLOAT";
                }
                else
                {
                    value = @"TEXT";
                }
                [classFields setObject:value forKey:key];
                [sql appendFormat:@",%@ %@", key, value];
            }
            [sql appendString:@")"];
            free(properties);
            
            [mdatabase executeUpdate:sql];
            [mdatabase beginTransaction];
            if(breplace)
            {
                [sql setString:@""];
                [sql appendFormat:@"DELETE FROM %@", tableName];
                [mdatabase executeUpdate:sql];
            }
        }
        
        [keys setString:@""];
        [values setString:@""];
        NSArray *allkeys = [classFields allKeys];
        NSArray *allvalues = [classFields allValues];
        outCount = (unsigned int)allkeys.count;
        for (int i = 0;i < outCount;i++)
        {
            if(i < outCount - 1)
            {
                [keys appendFormat:@"%@,", allkeys[i]];
                if([allvalues[i] isEqualToString:@"INTEGER"])
                {
                    [values appendFormat:@"%ld,", (long)[[wItem valueForKey:allkeys[i]] integerValue]];
                }
                else if([allvalues[i] isEqualToString:@"FLOAT"])
                {
                    [values appendFormat:@"%f,", [[wItem valueForKey:allkeys[i]] floatValue]];
                }
                else
                {
                    [values appendFormat:@"'%@',", [wItem valueForKey:allkeys[i]]];
                }
            }
            else
            {
                [keys appendString:allkeys[i]];
                if([allvalues[i] isEqualToString:@"INTEGER"])
                {
                    [values appendFormat:@"%ld", (long)[[wItem valueForKey:allkeys[i]] integerValue]];
                }
                else if([allvalues[i] isEqualToString:@"FLOAT"])
                {
                    [values appendFormat:@"%f", [[wItem valueForKey:allkeys[i]] floatValue]];
                }
                else
                {
                    [values appendFormat:@"'%@'", [wItem valueForKey:allkeys[i]]];
                }
            }
        }
        [sql setString:@""];
        [sql appendFormat:@"INSERT INTO %@(%@) VALUES (%@)", tableName, keys, values];
        [mdatabase executeUpdate:sql];
    }
    [mdatabase commit];
}

@end
