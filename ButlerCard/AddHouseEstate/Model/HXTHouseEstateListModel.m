//
//  HXTHouseEstateList.m
//  ButlerCard
//
//  Created by johnny tang on 4/29/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import "HXTHouseEstateListModel.h"
#import "AFNetworking.h"

@interface HXTHouseEstateListModel ()

@end

@implementation HXTHouseEstateListModel

- (void)loadDataFromServerWithAreaID:(NSString *)areaID andSearchWord:(NSString *)searchWord {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (areaID) {
        [parameters setObject:areaID forKey:@"area_id"];
    }
    
    if (searchWord) {
        [parameters setObject:searchWord forKey:@"search_word"];
    }
    
    if (parameters.allKeys.count == 0) {
        parameters = nil;
    }

    [[AFHTTPRequestOperationManager manager] POST:@"http://bbs.enveesoft.com:1602/htx/hexinpassserver/appserver/public/tenement/list"
                                       parameters:parameters
                                          success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                                              if ([responseObject[@"success"] integerValue] == 1) {
//                                                  
//                                                  NSLog(@"responseObject = %@", responseObject);
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      if (_delegate && [_delegate respondsToSelector:@selector(houseEstateListModel:DidFinishLoadingListModel:)]) {
                                                          [_delegate houseEstateListModel:self DidFinishLoadingListModel:responseObject[@"results"]];
                                                      }
                                                  });
                                                  
                                              }else  {
                                                  NSLog(@"####fail!!");
                                                  NSError *error = [[NSError alloc] initWithDomain:@"未知错误" code:[responseObject[@"success"] integerValue] userInfo:@{NSLocalizedDescriptionKey: @"未知错误"}];
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      if (_delegate && [_delegate respondsToSelector:@selector(houseEstateListModel:DidFailLoadingListModelWithError:)]) {
                                                          [_delegate houseEstateListModel:self DidFailLoadingListModelWithError:error];
                                                      }

                                                  });
                                              }
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                          }
                                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  if (_delegate && [_delegate respondsToSelector:@selector(houseEstateListModel:DidFailLoadingListModelWithError:)]) {
                                                      [_delegate houseEstateListModel:self DidFailLoadingListModelWithError:error];
                                                  }
                                                  
                                              });
                                              NSLog(@"Error: %@", error);
                                              NSLog(@"operation: %@", operation);
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                              
                                          }];
}

@end
