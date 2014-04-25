//
//  HXTAreaModel.m
//  ButlerCard
//
//  Created by johnny tang on 4/25/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import "HXTAreaModel.h"
#import "AFNetworking.h"
#import "HXTAreaFirstModel.h"
#import "HXTAppDelegate.h"
#import "HXTAreaSecModel.h"

@interface HXTAreaModel ()

@end

@implementation HXTAreaModel

+ (instancetype)sharedInstance {
    static HXTAreaModel *areaModel;
    if (!areaModel) {
        areaModel = [[HXTAreaModel alloc] init];
    }
    
    return areaModel;
}

#pragma mark - local functions

- (void)show {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
//        [[NSNotificationCenter defaultCenter] postNotificationName:kRegisteredAndLoginStartNotification object:self];
    });
    
//    NSDictionary *parameters = @{@"tel": username, @"password": password};
    [[AFHTTPRequestOperationManager manager] POST:@"http://bbs.enveesoft.com:1602/htx/hexinpassserver/appserver/public/tenement/area"
                                       parameters:nil
                                          success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                                              if ([responseObject[@"success"] integerValue] == 1) {
                                                  NSLog(@"getArea sucessed!!");
//                                                  NSDictionary *area = responseObject[@"results"];
//                                                  NSLog(@"area = %@", area);
//                                                  NSLog(@"成都 = %@", area[@"成都"]);
                                                  
                                              }else  {
                                                  NSLog(@"getArea Fail!");
                                              }
//                                              dispatch_async(dispatch_get_main_queue(), ^{
//                                                  NSLog(@"JSON: %@", responseObject);
//                                              });
                                          }
                                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                              NSLog(@"Error: %@", error);
                                              NSLog(@"operation: %@", operation);
    
                                          }];
    
    //让CoreData在上下文中创建一个新对象(托管对象)
    HXTAreaFirstModel *areaFirstModel = (HXTAreaFirstModel *)[NSEntityDescription insertNewObjectForEntityForName:@"HXTAreaFirstModel" inManagedObjectContext:((HXTAppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext];
    
    HXTAreaSecModel *areaSecModel = (HXTAreaSecModel *)[NSEntityDescription insertNewObjectForEntityForName:@"HXTAreaSecModel" inManagedObjectContext:((HXTAppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext];
    
    areaFirstModel.area = @"chengdu";
    
    areaSecModel.area = @"AAA";
    areaFirstModel.areaSecModel = areaSecModel;
    
    NSError *error;
    
    //托管对象准备好后，调用托管对象上下文的save方法将数据写入数据库
    BOOL isSaveSuccess = [((HXTAppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext save:&error];
    
    if (!isSaveSuccess) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }else {
        //            NSLog(@"Save successful!");
    }
    
    
    //创建取回数据请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //设置要检索哪种类型的实体对象
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HXTAreaFirstModel" inManagedObjectContext:((HXTAppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext];
    //设置请求实体
    [request setEntity:entity];
    
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(title = %@)",@"123"];
    //    [request setPredicate:predicate];
    
    //指定对结果的排序方式
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"area"ascending:YES];
    //排序条件 数组，可以多个条件排序
    NSArray *sortDescriptions = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];
    
//    NSError *error = nil;
    //执行获取数据请求，返回数组
    NSMutableArray *mutableFetchResult = [[((HXTAppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult == nil)
    {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }
    
    NSLog(@"mutableFetchResult = %@", mutableFetchResult);
    
    for(HXTAreaFirstModel *areaFirstModel in mutableFetchResult)
    {
        NSLog(@"HXTAreaFirstModel ------>  area:%@",areaFirstModel.area);
        NSLog(@"areaFirstModel.areaSecModel.area = %@", areaFirstModel.areaSecModel.area);
    }
}

@end
