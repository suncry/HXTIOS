//
//  HXTAddHouseEstateModel.m
//  ButlerCard
//
//  Created by johnny tang on 5/4/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import "HXTAddHouseEstateModel.h"
#import "AFNetworking.h"

@implementation HXTAddHouseEstateModel

- (void)addHouseEstateToServerWithUserID:(NSString *)userID
                           houseEstateID:(NSString *)houseEstateID
                              buildingNo:(NSString *)buildingNo
                                  unitNo:(NSString *)unitNo
                                 houseNo:(NSString *)houseNo
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (userID) {
        [parameters setObject:userID forKey:@"uid"];
    }
    
    if (houseEstateID) {
        [parameters setObject:houseEstateID forKey:@"tenement_id"];
    }
    
    if (buildingNo) {
        [parameters setObject:buildingNo forKey:@"building"];
    }
    
    if (unitNo) {
        [parameters setObject:unitNo forKey:@"unit"];
    }
    
    if (houseNo) {
        [parameters setObject:houseNo forKey:@"house"];
    }
    if (parameters.allKeys.count == 0) {
        parameters = nil;
    }
    
    [[AFHTTPRequestOperationManager manager] POST:@"http://bbs.enveesoft.com:1602/htx/hexinpassserver/appserver/public/tenement/open"
                                       parameters:parameters
                                          success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                                              if ([responseObject[@"success"] integerValue] == 1) {
                                                  NSLog(@"responseObject = %@", responseObject);
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      if (_delegate && [_delegate respondsToSelector:@selector(addHouseEstateModel:DidFinishAddHouseEstate:)]) {
                                                          [_delegate addHouseEstateModel:self DidFinishAddHouseEstate:responseObject[@"results"]];
                                                      }
                                                  });
                                                  
                                              }else  {
                                                  NSLog(@"####fail!!");
                                                  NSError *error = [[NSError alloc] initWithDomain:@"未知错误" code:[responseObject[@"success"] integerValue] userInfo:@{NSLocalizedDescriptionKey: @"未知错误"}];
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      if (_delegate && [_delegate respondsToSelector:@selector(addHouseEstateModel:DidFailAddHouseEstateWithError:)]) {
                                                          [_delegate addHouseEstateModel:self DidFailAddHouseEstateWithError:error];
                                                      }
                                                      
                                                  });
                                              }
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                          }
                                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  if (_delegate && [_delegate respondsToSelector:@selector(addHouseEstateModel:DidFailAddHouseEstateWithError:)]) {
                                                      [_delegate addHouseEstateModel:self DidFailAddHouseEstateWithError:error];
                                                  }
                                                  
                                              });
                                              NSLog(@"Error: %@", error);
                                              NSLog(@"operation: %@", operation);
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                              
                                          }];
    
}

@end
