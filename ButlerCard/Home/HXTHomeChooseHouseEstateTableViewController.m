//
//  HXTHomeChooseHouseEstateTableViewController.m
//  ButlerCard
//
//  Created by johnny tang on 4/14/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTHomeChooseHouseEstateTableViewController.h"
#import "HXTAccountManager.h"
#import "HXTLocationManager.h"

@interface HXTHomeChooseHouseEstateTableViewController ()

@property (copy, nonatomic) NSString *curAddress;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation HXTHomeChooseHouseEstateTableViewController

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
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(_reload:) forControlEvents:UIControlEventValueChanged];
    [self.tableView.tableHeaderView addSubview:self.refreshControl];
    
    [self.tableView.tableFooterView addSubview:self.refreshControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self _reload:nil];
}

#pragma mark - local functions

- (void)_reload:(__unused id)sender {
    
    //获得当前地址
    __block __weak HXTHomeChooseHouseEstateTableViewController *homeChooseHouseEstateTableViewController = self;
    
    [[HXTLocationManager sharedLocation] getAddress:^(NSString * addressString) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            homeChooseHouseEstateTableViewController.curAddress = addressString;
            NSLog(@"addressString = %@", addressString);
            NSIndexSet *indexSet= [NSIndexSet indexSetWithIndex:1];
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            [homeChooseHouseEstateTableViewController.refreshControl endRefreshing];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger numberOfRows;
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            numberOfRows = 1;
            break;
        case 1:
            numberOfRows = 1;
            break;
        case 2:
            numberOfRows = 3;
            break;
        case 3:
            numberOfRows = 6;
            break;
        default:
            numberOfRows = 0;
            break;
    }
    
    return numberOfRows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title;
    switch (section) {
        case 0:
            title = @" ";
            break;
        case 1:
            title = @"当前位置";
            break;
        case 2:
            title = @"我的小区";
            break;
        case 3:
            title = @"全部小区";
            break;
        default:
            title = @" ";
            break;
    }
    
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *allHouseEstateCellIdentifier      = @"AllHouseEstateCellIdentifier";
    static NSString *currentLocationCellIdentifier     = @"CurrentLocationCellIdentifier";
    static NSString *myHouseEstateCellIdentifier       = @"MyHouseEstateCellIdentifier";
    static NSString *theOtherHouseEstateCellIdentifier = @"TheOtherHouseEstateCellIdentifier";
    
    switch (indexPath.section) {
        case 0: { //全部商圈
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:allHouseEstateCellIdentifier forIndexPath:indexPath];
            return cell;
            break;
        }
        case 1: { //当前位置
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:currentLocationCellIdentifier forIndexPath:indexPath];
            
            ((UILabel *)[cell viewWithTag:102]).text = _curAddress? _curAddress: @"当前位置";
            ((UIActivityIndicatorView *)[cell viewWithTag:104]).hidden = YES;
            return cell;
            break;
        }
        case 2: { //我的小区
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myHouseEstateCellIdentifier forIndexPath:indexPath];
            return cell;
            break;
        }
        case 3: { //其它小区
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:theOtherHouseEstateCellIdentifier forIndexPath:indexPath];
            return cell;
            break;
        }
            
        default: {
            NSLog(@"%s %s %d Wrong section: %lu", __FILE__, __FUNCTION__, __LINE__, (long)indexPath.section);
            return nil;
            break;
        }
    }
    
}


#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell viewWithTag:102];
    NSLog(@"label.text = %@", label.text);
    
    [self dismissViewControllerAnimated:YES completion:^{
        if (![label.text isEqualToString:[HXTAccountManager sharedInstance].defaultHouseingEstate]) {
            [HXTAccountManager sharedInstance].defaultHouseingEstate = [label.text copy];
        }
    }];
    
}


#pragma mark - IB Actions


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
    [self dismissViewControllerAnimated:YES completion:^{}];
}
@end
