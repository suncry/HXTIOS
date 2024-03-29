//
//  CYMyCommentController.m
//  ButlerCard
//
//  Created by niko on 14-4-24.
//  Copyright (c) 2014年 johnny. All rights reserved.
//

#import "CYMyCommentController.h"
#import "DJQRateView.h"
#import "AFNetworking.h"

@interface CYMyCommentController ()

@end

@implementation CYMyCommentController

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
    [(DJQRateView *)[self.view viewWithTag:100] setRate:3];
    
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

- (IBAction)sendComment:(id)sender
{
    if (((UITextField *)[self.view viewWithTag:101]).text.length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"哎哟!" message:@"评论不能为空哦!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        NSString *gradeString = [NSString stringWithFormat:@"%f",((DJQRateView *)[self.view viewWithTag:100]).rate];
        NSString *commentString = [NSString stringWithFormat:@"%@",((UITextField *)[self.view viewWithTag:101]).text];
        NSLog(@"gradeString == %@",gradeString);
        NSLog(@"commentString == %@",commentString);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"uid": @"1",
                                     @"store_id": @"6",
                                     @"grade": gradeString,
                                     @"comment": commentString};
        [manager POST:@"http://bbs.enveesoft.com:1602/htx/hexinpassserver/appserver/public/store/comment-add" parameters:parameters
              success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
             hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark.png"]];
             hud.mode = MBProgressHUDModeCustomView;
             hud.labelText = @"评价已提交!";
             [hud show:YES];
             [hud hide:YES afterDelay:1.5];
             [self.navigationController popViewControllerAnimated:YES];

//             NSLog(@"responseObject == %@", responseObject);
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
             [self.navigationController popViewControllerAnimated:YES];


         }];
        

    }
}
@end
