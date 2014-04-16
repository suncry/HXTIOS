//
//  HXTTabBarViewController.m
//  ButlerCard
//
//  Created by johnny tang on 3/17/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTTabBarViewController.h"

@interface HXTTabBarViewController ()

@end

@implementation HXTTabBarViewController

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
    
//    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background"]; //del: 透明度太高会导致其他界面底层图像显式太明显
    [self.tabBar setSelectedImageTintColor:[UIColor colorWithRed:242.0f / 255 green:111.0f / 255 blue:14.f / 255 alpha:1.0f]];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) { //iOS 6 TabBar显式机制不一样，需要单独适配
        self.tabBar.backgroundColor = [UIColor whiteColor];
    } else {
//        self.tabBar.backgroundColor = [UIColor clearColor];
    }
    
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

@end
