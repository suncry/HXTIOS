//
//  HXTAreaModel.m
//  ButlerCard
//
//  Created by johnny tang on 4/25/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import "HXTAreaModel.h"
#import "AFNetworking.h"

#define kAreaSaveFileName @"areas.plist"

@interface HXTAreaModel ()

@property (strong, nonatomic) NSString *areaSaveFilePath;

@end


@implementation HXTAreaModel

@synthesize area = _area;

- (id)init {
    self = [super init];
    if (self) {
        _areaSaveFilePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:kAreaSaveFileName];
    }
    
    return self;
}

+ (instancetype)sharedInstance {
    static HXTAreaModel *areaModel;
    if (!areaModel) {
        areaModel = [[HXTAreaModel alloc] init];
    }
    
    return areaModel;
}

#pragma mark - local functions

- (void)setArea:(NSDictionary *)area {
    _area = area;
    
    [_area writeToFile:_areaSaveFilePath atomically:YES];
}


#pragma mark - public functions

- (NSDictionary *)area {
    
    _area = [[NSDictionary alloc] initWithContentsOfFile: _areaSaveFilePath];
    
    return _area;
}


- (void)loadDataFromServer {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [[AFHTTPRequestOperationManager manager] POST:@"http://bbs.enveesoft.com:1602/htx/hexinpassserver/appserver/public/tenement/area"
                                       parameters:nil
                                          success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                                              if ([responseObject[@"success"] integerValue] == 1) {
                                                  self.area = responseObject[@"results"];
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      if (_delegate && [_delegate respondsToSelector:@selector(areaModel:DidFinishLoadingArea:)]) {
                                                          [_delegate areaModel:self DidFinishLoadingArea:self.area];
                                                      }
                                                  });
                                                  
                                              }else  {
                                                  NSError *error = [[NSError alloc] initWithDomain:@"未知错误" code:[responseObject[@"success"] integerValue] userInfo:nil];
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      if (_delegate && [_delegate respondsToSelector:@selector(areaModel:DidFailLoadingAreaWithError:)]) {
                                                          [_delegate areaModel:self DidFailLoadingAreaWithError:error];
                                                      }
                                                  });
                                              }
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                          }
                                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  if (_delegate && [_delegate respondsToSelector:@selector(areaModel:DidFailLoadingAreaWithError:)]) {
                                                      [_delegate areaModel:self DidFailLoadingAreaWithError:error];
                                                  }
                                              });
                                              NSLog(@"Error: %@", error);
                                              NSLog(@"operation: %@", operation);
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                              
                                          }];
}

@end
