//
//  HXTOpenAutomaticBillPaymentViewController.m
//  ButlerCard
//
//  Created by johnny tang on 4/17/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import "HXTOpenAutomaticBillPaymentViewController.h"

@interface HXTOpenAutomaticBillPaymentViewController ()

@property (weak, nonatomic) IBOutlet UIButton *userAgreementCheckBox;

@end

@implementation HXTOpenAutomaticBillPaymentViewController

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
    _userAgreementCheckBox.selected = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IB Actions

- (IBAction)chechBoxChecked:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    switch (sender.tag) {
        case 101: {
            NSLog(@"物管费");
            break;
        }
        case 102: {
            NSLog(@"停车费");
            break;
        }
        case 103: {
            NSLog(@"水费");
            break;
        }
        case 104: {
            NSLog(@"电费");
            break;
        }
        case 105: {
            NSLog(@"气费");
            break;
        }
        case 106: {
            NSLog(@"代扣用户协议");
            break;
        }

        default:
            break;
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
