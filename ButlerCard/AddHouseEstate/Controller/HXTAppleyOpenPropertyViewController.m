//
//  HXTAppleyOpenPropertyViewController.m
//  ButlerCard
//
//  Created by johnny tang on 3/25/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTAppleyOpenPropertyViewController.h"

@interface HXTAppleyOpenPropertyViewController ()

@property (weak, nonatomic) IBOutlet UITextField *housingEstateNameTestField;

@end

@implementation HXTAppleyOpenPropertyViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_housingEstateNameTestField resignFirstResponder];
    
    return YES;
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) { //取消
        NSLog(@"取消");
    } else { //确定
        NSLog(@"确定");
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - IB Actions

- (IBAction)backgoudTouchUpInside:(id)sender {
    
    [_housingEstateNameTestField resignFirstResponder];
}


- (IBAction)applyButtonPressed:(id)sender {
    [_housingEstateNameTestField resignFirstResponder];
    NSString *alerString = [NSString  stringWithFormat:@"你申请开通的小区是%@", _housingEstateNameTestField.text];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:alerString
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定",nil];
    [alertView show];
}

#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backButtonPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
