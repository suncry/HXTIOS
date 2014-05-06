//
//  CYGesturePasswordViewController.m
//  ButlerCard
//
//  Created by niko on 14-5-5.
//  Copyright (c) 2014年 johnny. All rights reserved.
//

#import "CYGesturePasswordViewController.h"

@interface CYGesturePasswordViewController ()

@property (nonatomic,assign) ePasswordSate state;

@property (nonatomic,copy) NSString* password;

@property (nonatomic,retain) UIButton* clearButton;

@property (nonatomic,retain) UILabel* infoLabel;

@property (nonatomic,retain) MJPasswordView* passwordView;

@end

@implementation CYGesturePasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    self.password = [[NSUserDefaults standardUserDefaults]stringForKey:kGestureCode];
    [self updateInfoLabel];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.password = [[NSUserDefaults standardUserDefaults]stringForKey:kGestureCode];
    self.state = ePasswordExist;
    
    self.clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.clearButton.frame = CGRectMake(110, 20, 150, 30);
    [self.clearButton setTitle:@"重置密码为0125" forState:UIControlStateNormal];
    [self.clearButton addTarget:self action:@selector(clearPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.clearButton];
    
    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 300, 30)];
    self.infoLabel.backgroundColor = [UIColor clearColor];
    self.infoLabel.textAlignment =  NSTextAlignmentCenter;
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
        case ePasswordExist:
            infoText = [NSString stringWithFormat:@"密码设置成功，是:%@",self.password];
            break;
            
        default:
            break;
    }
    
    self.infoLabel.text = infoText;
}

- (void)clearPassword
{
    self.password = @"0125";
    self.state = ePasswordExist;
    
    [self updateInfoLabel];
}

- (void)passwordView:(MJPasswordView*)passwordView withPassword:(NSString*)password
{
    switch (self.state)
    {
        case ePasswordExist:
            if ([password isEqualToString:self.password])
            {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码正确！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                alert.tag = 100;
//                alert.delegate = self;
//                
//                [alert show];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码错误，请重试！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                alert.tag = 101;
                alert.delegate = self;
                [alert show];

                self.infoLabel.text = @"密码输入错误！";
            }
            
            break;
            
        default:
            break;
    }
    
    [self updateInfoLabel];
}

- (IBAction)forgetPassWord:(id)sender
{
    UIViewController *loginViewController = [[UIStoryboard storyboardWithName:@"AccountManager" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginStoryboardID"];
    [self.navigationController pushViewController:loginViewController animated:YES];
//    [self presentViewController:loginViewController animated:YES completion:nil];
}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    NSLog(@"alert tag == %d",alertView.tag);
//    //tag 100  密码正确alert
//    //tag 101  密码错误alert
//
//}

@end
