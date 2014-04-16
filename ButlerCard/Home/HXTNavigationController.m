//
//  HXTNavigationController.m
//  ButlerCard
//
//  Created by johnny tang on 3/19/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTNavigationController.h"

@interface HXTNavigationController ()

@end

@implementation HXTNavigationController

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
    
    switch (self.tabBarItem.tag) {
        case 0:{ //首页
            [self.tabBarItem  setSelectedImage:[UIImage imageNamed:@"tabbar_home_s"]];
        }
            break;
        case 1:{ //收藏
            [self.tabBarItem  setSelectedImage:[UIImage imageNamed:@"tabbar_collection_s"]];
        }
            break;
        case 2:{ //购物车
            [self.tabBarItem  setSelectedImage:[UIImage imageNamed:@"tabbar_message_s"]];
        }
            break;
        case 3:{ //我的管家
            [self.tabBarItem  setSelectedImage:[UIImage imageNamed:@"tabbar_myButler_s"]];
        }
            break;
            
        default:
            break;
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        //设置navigationBar背景色
        self.navigationBar.barTintColor = [UIColor colorWithRed:242.0f / 255 green:111.0f / 255 blue:14.f / 255 alpha:1.0f];
        
        //设置Title属性
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:255.0f / 255 green:192.0f / 255 blue:141.0f / 255 alpha:1.0f], UITextAttributeFont: [UIFont systemFontOfSize:18.0f]};
        
        self.navigationBar.tintColor = [UIColor whiteColor];
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
