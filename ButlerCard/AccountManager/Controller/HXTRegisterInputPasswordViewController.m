//
//  HXTRegisterInputPasswordViewController.m
//  ButlerCard
//
//  Created by johnny tang on 3/31/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTRegisterInputPasswordViewController.h"
#import "HXTAccountManager.h"
#import "NSString+Check.h"

@interface HXTRegisterInputPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputPasswordTestField;
@property (weak, nonatomic) IBOutlet UITextField *reInputPasswordTestField;
@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;

@end

@implementation HXTRegisterInputPasswordViewController

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_inputPasswordTestField becomeFirstResponder];
    
    if ([_inputPasswordTestField.text isValidPassword]
        && [_reInputPasswordTestField.text isValidPassword]
        && [_inputPasswordTestField.text isEqualToString:_reInputPasswordTestField.text])
    {
        _nextStepButton.enabled = YES;
    } else {
        _nextStepButton.enabled = NO;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationSelector:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - notification abserver

- (void)notificationSelector:(NSNotification *)notification {
    
#pragma mark - UITextFieldTextDidChangeNotification
    
    if ([notification.name isEqualToString:UITextFieldTextDidChangeNotification]) {
        if (notification.object == (id)_inputPasswordTestField || notification.object == (id)_reInputPasswordTestField) {
            if ([_inputPasswordTestField.text isValidPassword]
                && [_reInputPasswordTestField.text isValidPassword]
                && [_inputPasswordTestField.text isEqualToString:_reInputPasswordTestField.text])
            {
                _nextStepButton.enabled = YES;
            } else {
                _nextStepButton.enabled = NO;
            }
        }
    }
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _inputPasswordTestField) {
        [_reInputPasswordTestField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    _nextStepButton.enabled = NO;
    return YES;
}

#pragma mark - IB Actions

- (IBAction)backgroundTouchUpInside:(id)sender {
    if ([_inputPasswordTestField isFirstResponder]) {
        [_inputPasswordTestField resignFirstResponder];
    }
    
    if ([_reInputPasswordTestField isFirstResponder]) {
        [_reInputPasswordTestField resignFirstResponder];
    }
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"AddHouseEstateStoryboardSegue"]) {
        if (!_accountManager) {
            _accountManager = [[HXTAccountManager alloc] init];
        }
        _accountManager.password = _reInputPasswordTestField.text;
        [segue.destinationViewController setValue:_accountManager forKey:@"accountManager"];
    }
}

@end
