//
//  CYPassWordViewController.m
//  ButlerCard
//
//  Created by niko on 14-5-5.
//  Copyright (c) 2014年 johnny. All rights reserved.
//

#import "CYPassWordViewController.h"

@interface CYPassWordViewController ()

@property (nonatomic,assign) ePasswordSate state;

@property (nonatomic,copy) NSString* password;

@property (nonatomic,retain) UIButton* clearButton;

@property (nonatomic,retain) UILabel* infoLabel;

@property (nonatomic,retain) MJPasswordView* passwordView;

@end

@implementation CYPassWordViewController

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
    
    self.clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.clearButton.frame = CGRectMake(110, 20, 100, 30);
    [self.clearButton setTitle:@"清空密码" forState:UIControlStateNormal];
    [self.clearButton addTarget:self action:@selector(clearPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.clearButton];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
    self.password = @"";
    self.state = ePasswordUnset;
    
    [self updateInfoLabel];
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
                self.state = ePasswordExist;
                UIAlertView* view = [[UIAlertView alloc] initWithTitle:@"密码设置成功！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [view show];
            }
            break;
            
        case ePasswordExist:
            if ([password isEqualToString:self.password])
            {
                UIAlertView* view = [[UIAlertView alloc] initWithTitle:@"密码正确！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [view show];
            }
            else
            {
                UIAlertView* view = [[UIAlertView alloc] initWithTitle:@"密码错误，请重试！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [view show];
            }
            
            break;
            
        default:
            break;
    }
    
    [self updateInfoLabel];
}

- (IBAction)forgetPassWord:(id)sender
{
    [self presentViewController:[[UIStoryboard storyboardWithName:@"Home" bundle:nil]instantiateInitialViewController] animated:YES completion:nil];
}
@end
