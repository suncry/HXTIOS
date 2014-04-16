//
//  HXTPropertyServiceViewController.m
//  ButlerCard
//
//  Created by niko on 14-4-11.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import "HXTPropertyServiceViewController.h"
#import "CYHouseChoiceController.h"
#import "AFNetworking.h"
@interface HXTPropertyServiceViewController ()

@end

@implementation HXTPropertyServiceViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.houseNameBtn setTitle:[NSString stringWithFormat:@"%@ ▾",[[NSUserDefaults standardUserDefaults]valueForKeyPath:kHouseName]] forState:UIControlStateNormal];
    //每次进入页面都根据所选择住址刷新一遍页面内容
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    [HUD showWhileExecuting:@selector(request) onTarget:self withObject:nil animated:YES];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //假定一个默认的住址
    [[NSUserDefaults standardUserDefaults]setValue:@"默认的第一个住址" forKeyPath:kHouseName];
    
    self.rentRateView.rate = 3.5;
    self.repairRateView.rate = 4.5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
/**
 *  提交服务申请
 */
- (void)request
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"tenement_id": @"1"};
    [manager POST:@"http://bbs.enveesoft.com:1602/htx/hexinpassserver/appserver/public/serv/top" parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         _dataArr = responseObject[@"results"];
//         NSLog(@"_dataArr == %@",_dataArr);
         NSDictionary *rentDic = _dataArr[0];
         NSDictionary *repairDic = _dataArr[1];

         _rentRateView.rate = [rentDic[@"grade"]floatValue];
         _repairRateView.rate = [repairDic[@"grade"]floatValue];
         [_rentCommentBtn setTitle:[NSString stringWithFormat:@"评论(%@)",rentDic[@"commentNum"]] forState:UIControlStateNormal];
         [_repairCommentBtn setTitle:[NSString stringWithFormat:@"评论(%@)",repairDic[@"commentNum"]] forState:UIControlStateNormal];


     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}

@end
