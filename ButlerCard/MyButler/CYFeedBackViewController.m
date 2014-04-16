//
//  CYFeedBackViewController.m
//  ButlerCard
//
//  Created by niko on 14-3-25.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import "CYFeedBackViewController.h"

@interface CYFeedBackViewController ()

@end

@implementation CYFeedBackViewController

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
- (IBAction)sendBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
