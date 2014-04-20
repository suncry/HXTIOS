//
//  HXTHomeViewController.m
//  ButlerCard
//
//  Created by johnny tang on 2/20/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTHomeViewController.h"
#import "UIDevice+Resolutions.h"
#import "HXTAccountManager.h"
#import "NSString+FontAwesome.h"
#import "UIFont+FontAwesome.h"

@interface HXTHomeViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *chooseHouseEstateBarButtonItem;
@property (weak, nonatomic) IBOutlet UIButton *propertyServiceButton;
@property (weak, nonatomic) IBOutlet UIButton *propertyFeeButton;
@property (weak, nonatomic) IBOutlet UIButton *surroundingLifeButton;
@property (weak, nonatomic) IBOutlet UIButton *houseEstateInteractionButton;
@property (weak, nonatomic) IBOutlet UIButton *sellerButton;
@property (weak, nonatomic) IBOutlet UITableView *messageTableView;

@property (strong, nonatomic) UIViewController *nextStepViewController;

@end

@implementation HXTHomeViewController

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
    [_chooseHouseEstateBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], UITextAttributeFont: [UIFont fontAwesomeFontOfSize:18.0f]} forState:UIControlStateNormal];
    if ([HXTAccountManager sharedInstance].defaultHouseingEstate) {
        _chooseHouseEstateBarButtonItem.title = [NSString stringWithFormat:@"%@ %@", [HXTAccountManager sharedInstance].defaultHouseingEstate, [NSString fontAwesomeIconStringForIconIdentifier:@"icon-angle-down"]];
    } else {
        _chooseHouseEstateBarButtonItem.title = [NSString stringWithFormat:@"%@ %@", @"全部商圈", [NSString fontAwesomeIconStringForIconIdentifier:@"icon-angle-down"]];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //从登录界面返回后进入物业服务页面
    if (_propertyServiceButton.selected && [HXTAccountManager sharedInstance].logged) {
        UIViewController *propertyServiceViewController = [[UIStoryboard storyboardWithName:@"PropertyService" bundle:nil] instantiateViewControllerWithIdentifier:@"PropertyServiceStoryboardID"];
        [self.navigationController pushViewController:propertyServiceViewController animated:YES];
    } else if (_propertyFeeButton.selected && [HXTAccountManager sharedInstance].logged) {
        UIViewController *propertyFeeViewcontroller = [[UIStoryboard storyboardWithName:@"PropertyFee" bundle:nil] instantiateViewControllerWithIdentifier:@"PropertyFeeStoryboardID"];
        [self.navigationController pushViewController:propertyFeeViewcontroller animated:YES];
    }
    
    _propertyServiceButton.selected = NO;
    _propertyFeeButton.selected = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *messageGreenCellIdentifier = @"MessageGreenCellIdentifier";
    static NSString *messageRedCellIdentifier = @"MessageRedCellIdentifier";
    
    if (indexPath.row % 2 ) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:messageRedCellIdentifier forIndexPath:indexPath];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:messageGreenCellIdentifier forIndexPath:indexPath];
        return cell;
    }
}

#pragma mark - Table view delegate


#pragma mark - IB Actions

//物管服务
- (IBAction)propertyServiceButtonPressed:(UIButton *)sender {
    sender.selected = YES;
    
    if ([HXTAccountManager sharedInstance].logged) {
        UIViewController *propertyServiceViewController = [[UIStoryboard storyboardWithName:@"PropertyService" bundle:nil] instantiateViewControllerWithIdentifier:@"PropertyServiceStoryboardID"];
        [self.navigationController pushViewController:propertyServiceViewController animated:YES];
        sender.selected = NO;
    } else {
        UIViewController *accountManagerNavViewController = [[UIStoryboard storyboardWithName:@"AccountManager" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"AccountManagerNavStoryboardID"];
        [self presentViewController:accountManagerNavViewController animated:YES completion:^{ }];
    }
}

//物业缴费
- (IBAction)propertyFeeButtonPressed:(UIButton *)sender {
    sender.selected = YES;
    
    if ([HXTAccountManager sharedInstance].logged) {
        UITableViewController *propertyFeeViewController = [[UIStoryboard storyboardWithName:@"PropertyFee" bundle:nil] instantiateViewControllerWithIdentifier:@"PropertyFeeStoryboardID"];
        [self.navigationController pushViewController:propertyFeeViewController animated:YES];
        sender.selected = NO;
    } else {
        UIViewController *browseHouseEstateNavViewController = [[UIStoryboard storyboardWithName:@"BrowseHouseEstate" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"BrowseHouseEstateNavStoryboardID"];
        [self presentViewController:browseHouseEstateNavViewController animated:YES completion:^{}];
    }
}

//周边生活
- (IBAction)surroundingLifeButtonPressed:(UIButton *)sender {
    sender.selected = YES;
    NSLog(@"周边生活 %s %s %d", __FILE__, __FUNCTION__, __LINE__);
    
    UIViewController *surroundingLifeViewController = [[UIStoryboard storyboardWithName:@"SurroundingLife" bundle:nil] instantiateViewControllerWithIdentifier:@"SurroundingLifeStoryboardID"];
    [self.navigationController pushViewController:surroundingLifeViewController animated:YES];
    sender.selected = NO;
}


//小区互动
- (IBAction)houseEstateInteractionButtonPressed:(UIButton *)sender {
    sender.selected = YES;
    NSLog(@"小区互动 %s %s %d", __FILE__, __FUNCTION__, __LINE__);
    sender.selected = NO;
}

//商家登录
- (IBAction)sellerButtonPressed:(UIButton *)sender {
    sender.selected = YES;
    NSLog(@"商家登录 %s %s %d", __FILE__, __FUNCTION__, __LINE__);
    UIViewController *ecologicalDistributionViewcontroller = [[UIStoryboard storyboardWithName:@"EcologicalDistribution" bundle:nil] instantiateViewControllerWithIdentifier:@"EcologicalDistributionStoryboardID"];
    [self.navigationController pushViewController:ecologicalDistributionViewcontroller animated:YES];
    sender.selected = NO;
}



@end
