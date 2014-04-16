//
//  CYRentController.m
//  ButlerCard
//
//  Created by niko on 14-4-15.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import "CYRentController.h"
#import "AFNetworking.h"
@interface CYRentController ()

@end

@implementation CYRentController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //提示的文字
    NSString *str = [NSString stringWithFormat:@"你确认要租借%@吗？",((UILabel *)[tableView viewWithTag:100 + indexPath.row]).text];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"服务确认" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert show];
}
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex == %d",buttonIndex);
    //点击确认按钮 发送服务请求
    if (buttonIndex == 1)
    {
    }
}
- (void)request
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"uid": @"1",@"tenement_serv_id": @"1"};
    [manager POST:@"http://bbs.enveesoft.com:1602/htx/hexinpassserver/appserver/public/announce/apply" parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //             NSLog(@"responseObject == %@",responseObject);
         NSLog(@"服务请求已提交");
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}
@end
