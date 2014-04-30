//
//  HXTHouseListModel.m
//  ButlerCard
//
//  Created by johnny tang on 4/30/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import "HXTHouseListModel.h"
#import "AFNetworking.h"

@interface HXTHouseListModel ()

@end

@implementation HXTHouseListModel

- (void)loadDataFromServerWithHouseEstateID:(NSString *)houseEstateID {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (houseEstateID) {
        [parameters setObject:houseEstateID forKey:@"area_id"];
    }
    
    if (parameters.allKeys.count == 0) {
        parameters = nil;
    }
    
    [[AFHTTPRequestOperationManager manager] POST:@"http://bbs.enveesoft.com:1602/htx/hexinpassserver/appserver/public/tenement/detail"
                                       parameters:parameters
                                          success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                                              if ([responseObject[@"success"] integerValue] == 1) {
//                                                  NSLog(@"responseObject = %@", responseObject);
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      if (_delegate && [_delegate respondsToSelector:@selector(houseListModel:DidFinishLoadingListModel:)]) {
                                                          [_delegate houseListModel:self DidFinishLoadingListModel:responseObject[@"results"]];
                                                      }
                                                  });
                                                  
                                              }else  {
                                                  NSLog(@"####fail!!");
                                                  NSError *error = [[NSError alloc] initWithDomain:@"未知错误" code:[responseObject[@"success"] integerValue] userInfo:nil];
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      if (_delegate && [_delegate respondsToSelector:@selector(houseListModel:DidFailLoadingListModelWithError:)]) {
                                                          [_delegate houseListModel:self DidFailLoadingListModelWithError:error];
                                                      }
                                                      
                                                  });
                                              }
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                          }
                                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  if (_delegate && [_delegate respondsToSelector:@selector(houseListModel:DidFailLoadingListModelWithError:)]) {
                                                      [_delegate houseListModel:self DidFailLoadingListModelWithError:error];
                                                  }
                                                  
                                              });
                                              NSLog(@"Error: %@", error);
                                              NSLog(@"operation: %@", operation);
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                              
                                          }];
    
}
@end
