//
//  HXTPayViewController.m
//  ButlerCard
//
//  Created by johnny tang on 5/5/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import "HXTPayViewController.h"

@interface HXTPayViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HXTPayViewController

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

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *feeItemCellIdentifier = @"feeItemCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:feeItemCellIdentifier forIndexPath:indexPath];
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"Text";
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

- (IBAction)cancelBarButtonItemPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}
@end
