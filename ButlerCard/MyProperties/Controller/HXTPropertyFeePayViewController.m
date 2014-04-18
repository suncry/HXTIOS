//
//  HXTPropertyFeePayViewController.m
//  ButlerCard
//
//  Created by johnny tang on 4/18/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import "HXTPropertyFeePayViewController.h"

@interface HXTPropertyFeePayViewController ()

@property (weak, nonatomic) IBOutlet UITableView *propertyFeeItemsTabelView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *payMethordSegmentedControl;

@end

@implementation HXTPropertyFeePayViewController

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

#pragma mark - table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *TypeOneCellIdentifier = @"TypeOneCellIdentifier";
//    static NSString *TypeTwoCellIdentifier = @"TypeTwoCellIdentifier";
    static NSString *TypeThreeCellIdentifier = @"TypeThreeCellIdentifier";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TypeThreeCellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - IB Actions


- (IBAction)chechBoxChecked:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)lowerDateSelectorButtonPressed:(id)sender {
    
}

- (IBAction)uperDateSelectorButtonPressed:(id)sender {
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

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}
@end
