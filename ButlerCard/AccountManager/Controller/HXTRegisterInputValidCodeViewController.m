//
//  HXTRegisterInputValidCodeViewController.m
//  ButlerCard
//
//  Created by johnny tang on 3/31/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTRegisterInputValidCodeViewController.h"
#import "HXTAccountManager.h"

@interface HXTRegisterInputValidCodeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *validCodeTestField;

@end

@implementation HXTRegisterInputValidCodeViewController

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
    
    [_validCodeTestField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IB Actions

- (IBAction)backgroundTouchUpInside:(id)sender {
    [_validCodeTestField resignFirstResponder];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"InputPasswordStoryboardSegue"]) {
        if (!_accountManager) {
            _accountManager = [[HXTAccountManager alloc] init];
        }
        [segue.destinationViewController setValue:_accountManager forKey:@"accountManager"];
    }
}


@end
