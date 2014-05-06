//
//  CYRequesetCardsViewController.m
//  ButlerCard
//
//  Created by niko on 14-5-5.
//  Copyright (c) 2014年 johnny. All rights reserved.
//

#import "CYRequesetCardsViewController.h"
#import "AFNetworking.h"

@interface CYRequesetCardsViewController ()
@end

@implementation CYRequesetCardsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sendBtnClick:(id)sender
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    [HUD showWhileExecuting:@selector(request) onTarget:self withObject:nil animated:YES];
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
//         NSLog(@"responseObject == %@",responseObject);
         UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"恭喜您，申领业主卡主卡成功。将会在5个工作日内寄达。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
         
         [alert show];
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
