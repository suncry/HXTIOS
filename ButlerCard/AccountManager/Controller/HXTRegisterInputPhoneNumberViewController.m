//
//  HXTRegisterInputPhoneNumberViewController.m
//  ButlerCard
//
//  Created by johnny tang on 3/31/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTRegisterInputPhoneNumberViewController.h"
#import "HXTAccountManager.h"
#import "NSString+Check.h"

@interface HXTRegisterInputPhoneNumberViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNuberTestField;
@property (weak, nonatomic) IBOutlet UIButton *chockBox;
@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;

@property (strong, nonatomic)HXTAccountManager *accountManager; //用于传值

@end

@implementation HXTRegisterInputPhoneNumberViewController

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
    
    _accountManager = [[HXTAccountManager alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_phoneNuberTestField becomeFirstResponder];
    _chockBox.selected = YES;
    
    if ([_phoneNuberTestField.text isValidPhoneNum] && _chockBox.selected) {
        _nextStepButton.enabled = YES;
    } else {
        _nextStepButton.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    _nextStepButton.enabled = NO;
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"string = #%@#, string.leng = %lu", string, (long)string.length);
    if (textField.text.length >= 11 && string.length) {
        return NO;
    } else
    
    if ([[textField.text stringByAppendingString:string] isValidPhoneNum] && _chockBox.selected) {
        _nextStepButton.enabled = YES;
    } else {
        _nextStepButton.enabled = NO;
    }
    
    return YES;
}

#pragma mark - IB Actions
- (IBAction)checkBoxButtonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if ([_phoneNuberTestField.text isValidPhoneNum] && _chockBox.selected) {
        _nextStepButton.enabled = YES;
    } else {
        _nextStepButton.enabled = NO;
    }
}

- (IBAction)backgoundTouchUpInside:(id)sender {
    [_phoneNuberTestField resignFirstResponder];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"InputValidCodeStoryboardSegue"]) {
        if (!_accountManager) {
            _accountManager = [[HXTAccountManager alloc] init];
        }
        _accountManager.username = _phoneNuberTestField.text;
        [segue.destinationViewController setValue:_accountManager forKey:@"accountManager"];
    }
}


@end
