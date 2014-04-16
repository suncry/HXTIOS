//
//  HXTSelectCitySecondLevelViewController.m
//  ButlerCard
//
//  Created by johnny tang on 3/19/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTSelectCitySecondLevelViewController.h"

@interface HXTSelectCitySecondLevelViewController ()

@end

@implementation HXTSelectCitySecondLevelViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IB Actions

- (IBAction)backButtonPressed:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
