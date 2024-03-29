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
    if (indexPath.section == 0)
    {
        NSString *str = [NSString stringWithFormat:@"你确认要租借%@吗？",((UILabel *)[tableView viewWithTag:100 + indexPath.row]).text];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"服务确认" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alert show];

    }
}
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex == %ld",(long)buttonIndex);
    //点击确认按钮 发送服务请求
    if (buttonIndex == 1)
    {
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        
        // Regiser for HUD callbacks so we can remove it from the window at the right time
        HUD.delegate = self;
        
        // Show the HUD while the provided method executes in a new thread
        [HUD showWhileExecuting:@selector(request) onTarget:self withObject:nil animated:YES];

    }
}
/**
 *  提交服务申请
 */
- (void)request
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"uid": @"1",@"tenement_serv_id": @"1"};
    [manager POST:@"http://bbs.enveesoft.com:1602/htx/hexinpassserver/appserver/public/announce/apply" parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
         hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark.png"]];
         hud.mode = MBProgressHUDModeCustomView;
         hud.labelText = @"申请已提交!";
         [hud show:YES];
         [hud hide:YES afterDelay:1.5];

     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
         hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark.png"]];
         hud.mode = MBProgressHUDModeCustomView;
         hud.labelText = [NSString stringWithFormat:@"无网络连接!!!"];
         [hud show:YES];
         [hud hide:YES afterDelay:1.5];

     }];
}
- (IBAction)takeCall:(id)sender
{
    NSString *number = @"10010";// 此处读入电话号码
    
    // NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法 结束电话之后会进入联系人列表
    
    
    
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
    

}

@end
