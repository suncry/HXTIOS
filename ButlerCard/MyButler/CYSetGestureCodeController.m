//
//  CYSetGestureCodeController.m
//  ButlerCard
//
//  Created by niko on 14-5-6.
//  Copyright (c) 2014年 johnny. All rights reserved.
//

#import "CYSetGestureCodeController.h"

@interface CYSetGestureCodeController ()
@property (nonatomic,assign) ePasswordSate state;

@property (nonatomic,copy) NSString* password;

@property (nonatomic,retain) UIButton* clearButton;

@property (nonatomic,retain) UILabel* infoLabel;

@property (nonatomic,retain) MJPasswordView* passwordView;

@end

@implementation CYSetGestureCodeController

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
    self.password = @"";
    self.state = ePasswordUnset;
    
    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 300, 30)];
    self.infoLabel.backgroundColor = [UIColor clearColor];
    if ([[UIDevice currentDevice].systemVersion floatValue]>=6.0)
    {
        self.infoLabel.textAlignment =  NSTextAlignmentCenter;
    }
    else
    {
        //        self.infoLabel.textAlignment = UITextAlignmentCenter;
    }
    self.infoLabel.textColor = [UIColor redColor];
    [self.view addSubview:self.infoLabel];
    
    CGRect frame = CGRectMake(20, 100, kPasswordViewSideLength, kPasswordViewSideLength);
    self.passwordView = [[MJPasswordView alloc] initWithFrame:frame];
    self.passwordView.delegate = self;
    [self.view addSubview:self.passwordView];
    
    [self updateInfoLabel];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)updateInfoLabel
{
    NSString* infoText;
    switch (self.state)
    {
        case ePasswordUnset:
            infoText = @"请滑动九宫格，设置密码";
            break;
            
        case ePasswordRepeat:
            infoText = [NSString stringWithFormat:@"请再次输入刚才的密码:%@",self.password];
            break;
            
        default:
            break;
    }
    
    self.infoLabel.text = infoText;
}
- (void)passwordView:(MJPasswordView*)passwordView withPassword:(NSString*)password
{
    switch (self.state)
    {
        case ePasswordUnset:
            self.password = password;
            self.state = ePasswordRepeat;
            break;
            
        case ePasswordRepeat:
            if ([password isEqualToString:self.password])
            {
//                self.state = ePasswordExist;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码设置成功！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                alert.tag = 100;
                alert.delegate = self;
                [alert show];
                [[NSUserDefaults standardUserDefaults]setObject:password forKey:kGestureCode];
                NSLog(@"手势密码设置为:%@",[[NSUserDefaults standardUserDefaults]stringForKey:kGestureCode]);
            }
            else
            {
                //设置失败 返回最初状态
                self.state = ePasswordUnset;
            }
            break;
            
        default:
            break;
    }
    
    [self updateInfoLabel];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"alert tag == %d",alertView.tag);
    //tag 100  密码正确alert
    [self.navigationController popViewControllerAnimated:YES];
    //tag 101  密码错误alert
    
}

@end
