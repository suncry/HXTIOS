//
//  HXTLoginViewController.m
//  ButlerCard
//
//  Created by johnny tang on 2/21/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTLoginViewController.h"
#import "HXTCheckBox.h"
#import "HXTAccountManager.h"
#import "NSString+Check.h"
#import "MBProgressHUD.h"

@interface HXTLoginViewController () <UITextFieldDelegate, MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (strong, nonatomic) MBProgressHUD *HUD;

@end

@implementation HXTLoginViewController

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
    _userNameTextField.delegate = self;
    _passwordTextField.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldTextDidChangeNotificatioSelector:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginNotificationSelector:)
                                                 name:kLoginSuccessNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginNotificationSelector:)
                                                 name:kLoginFailedNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_userNameTextField becomeFirstResponder];
    
    if ([_userNameTextField.text isValidPhoneNum] && [_passwordTextField.text isValidPassword]) {
        _loginButton.enabled = YES;
    } else {
        _loginButton.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - notification abserver

- (void)loginNotificationSelector:(NSNotification *)notification {
    [_HUD hide:YES];
    
    NSLog(@"notification.name = %@", notification.name);
    if ([notification.name isEqualToString:kLoginSuccessNotification]) {
        [self dismissViewControllerAnimated:NO completion:^{ }];
    } else if ([notification.name isEqualToString:kLoginFailedNotification]) {
        if (notification.userInfo) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录失败"
                                                                message:notification.userInfo[@"NSLocalizedDescription"]
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }
}

- (void)textFieldTextDidChangeNotificatioSelector:(NSNotification *)notification {
    
    if ([notification.name isEqualToString:UITextFieldTextDidChangeNotification]) {
        if (notification.object == (id)_userNameTextField || notification.object == (id)_passwordTextField) {
            if ([_userNameTextField.text isValidPhoneNum] && [_passwordTextField.text isValidPassword]) {
                _loginButton.enabled = YES;
            } else {
                _loginButton.enabled = NO;
            }
        }
    }
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _userNameTextField) {
        [_passwordTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    _loginButton.enabled = NO;
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == _userNameTextField && textField.text.length >= 11 && string.length) { //手机号码限定为11位
        return NO;
    }
    
    return YES;
}

#pragma mark - IB Actions

- (IBAction)backgroundTouchUpInside:(id)sender {
    [self dismissKeyboard];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"UserRegisterStoryboardSegueIdentifier"]) {
        [self dismissKeyboard];
        [segue.destinationViewController setValue:self forKey:@"delegate"];
    }
}

- (IBAction)forgetPassordButtonPressed:(UIButton *)sender {
    [self dismissKeyboard];
}


- (IBAction)loginButtonPressed:(UIButton *)sender {
    if ([_userNameTextField.text isValidPhoneNum] && [_passwordTextField.text isValidPassword]) {
        
        // The hud will dispable all input on the window
        if (!_HUD) {
            _HUD = [[MBProgressHUD alloc] initWithView:self.view.window];
        }
        
        [[UIApplication sharedApplication].windows.lastObject addSubview:_HUD];
        //        [self.view.window addSubview:_HUD];
        
        _HUD.delegate = self;
        _HUD.labelText = @"登录...";
        [_HUD show:YES];
        [[HXTAccountManager sharedInstance] loginWithUsername:_userNameTextField.text password:_passwordTextField.text];
        
    } else {
        
    }
}

- (void)dismissKeyboard {
    if ( [_userNameTextField isEditing] ) {
        [_userNameTextField resignFirstResponder];
    } else if ([_passwordTextField isEditing]) {
        [_passwordTextField resignFirstResponder];
    }
}

#pragma mark - MBProgressHUD Delegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[_HUD removeFromSuperview];
}


#pragma mark - Navigation

- (IBAction)backButtonPressed:(id)sender {
    
    if (self.navigationController.viewControllers.count > 1) { //其他Controller通过导航控制器进入该页面
        [self.navigationController popViewControllerAnimated:YES];
    } else { //使用的模态方式进入改页面
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
}

@end
