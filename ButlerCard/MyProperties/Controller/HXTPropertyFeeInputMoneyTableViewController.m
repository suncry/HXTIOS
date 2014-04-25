//
//  HXTPropertyFeeInputMoneyTableViewController.m
//  ButlerCard
//
//  Created by johnny tang on 4/25/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import "HXTPropertyFeeInputMoneyTableViewController.h"

@interface HXTPropertyFeeInputMoneyTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;

@end

@implementation HXTPropertyFeeInputMoneyTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_moneyTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)moneyButtonPressed:(UIButton *)sender {
    switch (sender.tag) {
        case 101:
            NSLog(@"50元");
            _moneyTextField.text = @"50.00元";
            break;
        case 102:
            NSLog(@"100元");
            _moneyTextField.text = @"100.00元";
            break;
        case 103:
            NSLog(@"200元");
            _moneyTextField.text = @"200.00元";
            break;
        case 104:
            NSLog(@"500元");
            _moneyTextField.text = @"500.00元";
            break;
        default:
            break;
    }
    
    [self _done];
}

#pragma mark - local functions

-(void)_done {
    [self dismissViewControllerAnimated:YES completion:^{
        float money = [_moneyTextField.text floatValue];
        NSString *moneyStr = [NSString stringWithFormat:@"%0.2f元",money];
        [[NSNotificationCenter defaultCenter] postNotificationName:kInputMoneyNotification object:self userInfo:@{@"money": moneyStr}];
    }];
}

#pragma mark - Navigation

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    
    }];
}

- (IBAction)doneButtonPressed:(id)sender {
    [self _done];
}

@end
