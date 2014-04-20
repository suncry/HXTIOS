//
//  HXTBindCardViewController.m
//  ButlerCard
//
//  Created by johnny tang on 3/13/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTBindCardViewController.h"

@interface HXTBindCardViewController () <UITextFieldDelegate, UIActionSheetDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *feeTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *remarkTestField;
@property (weak, nonatomic) IBOutlet UIButton *telButton;

@property (strong, nonatomic) UIActionSheet *feeTypeActionSheet;
@property (strong, nonatomic) UIActionSheet *areaActionSheet;
@property (strong, nonatomic) UIActionSheet *companyActionSheet;

@property (strong, nonatomic) NSArray *feeTypeArray;
@property (strong, nonatomic) NSArray *areaArray;
@property (strong, nonatomic) NSArray *companyArray;

@property (strong, nonatomic) UIAlertView *telAlerView;

@end

@implementation HXTBindCardViewController

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
    _feeTypeArray = @[@"物管费", @"停车费", @"水费", @"电费", @"气费"];
    _areaArray    = @[@"成都市", @"双流县", @"温江区", @"郫县"];
    _companyArray = @[@"A物业公司", @"自来水公司", @"电力公司", @"天然气公司"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -- UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex = %lu", (long)buttonIndex);
    if (actionSheet == _feeTypeActionSheet && buttonIndex < _feeTypeArray.count) {
        _feeTypeLabel.text = _feeTypeArray[buttonIndex];
    } else if (actionSheet == _areaActionSheet && buttonIndex < _areaArray.count){
        _areaLabel.text = _areaArray[buttonIndex];
    } else if (actionSheet == _companyActionSheet && buttonIndex < _companyArray.count){
        _companyLabel.text = _companyArray[buttonIndex];
    }
}

#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex = %lu", (long)buttonIndex);
    if (alertView == _telAlerView && buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString stringWithFormat:@"tel://%@", _telButton.titleLabel.text] stringByReplacingOccurrencesOfString:@"-" withString:@""]]];
    }
}

#pragma mark - IB Actions

- (IBAction)feeTypeButtonPressed:(id)sender {
    NSLog(@"feeTypeButtonPressed");
    _feeTypeActionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:_feeTypeArray[0], _feeTypeArray[1], _feeTypeArray[2], _feeTypeArray[3], _feeTypeArray[4], nil];
    [_feeTypeActionSheet showInView:self.view.window];
}

- (IBAction)areaButtonPressed:(id)sender {
    NSLog(@"areaButtonPressed");
    
    NSLog(@"companyButtonPressed");
    _areaActionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:_areaArray[0], _areaArray[1], _areaArray[2], _areaArray[3], nil];
    [_areaActionSheet showInView:self.view.window];
}

- (IBAction)companyButtonPressed:(id)sender {
    NSLog(@"companyButtonPressed");
    _companyActionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:_companyArray[0], _companyArray[1], _companyArray[2], _companyArray[3], nil];
    [_companyActionSheet showInView:self.view.window];
}

- (IBAction)applyButtonPressed:(UIButton *)sender {
    sender.selected = YES;
    sender.selected = NO;
    NSLog(@"applyButtonPressed");
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)telButtonPressed:(UIButton *)sender {
    if (!_telAlerView) {
        _telAlerView = [[UIAlertView alloc] initWithTitle:nil
                                                  message:sender.titleLabel.text
                                                 delegate:self
                                        cancelButtonTitle:@"取消"
                                        otherButtonTitles:@"呼叫", nil];
    }
    
    [_telAlerView show];
}

- (IBAction)addressButtonPressed:(id)sender {
    
}

- (IBAction)backgroundTouchUpInside:(id)sender {
    
    if ( [_cardNumberTextField isEditing] ) {
        [_cardNumberTextField resignFirstResponder];
    } else if ([_remarkTestField isEditing]) {
        [_remarkTestField resignFirstResponder];
    }
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
