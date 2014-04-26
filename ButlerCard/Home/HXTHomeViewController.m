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

#define kLoginSegue             @"loginSegue"
#define kPropertyServiceSegue   @"propertyServiceSegue"
#define kPropertyFeeSegue       @"propertyFeeSegue"
#define kBrowseHouseEstateSegue @"browseHouseEstateSegue"
#define kSurroundingLifeSegue   @"surroundingLifeSegue"

@interface HXTHomeViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *chooseHouseEstateBarButtonItem;
@property (weak, nonatomic) IBOutlet UIButton *propertyServiceButton;
@property (weak, nonatomic) IBOutlet UIButton *propertyFeeButton;
@property (weak, nonatomic) IBOutlet UIButton *surroundingLifeButton;
@property (weak, nonatomic) IBOutlet UIButton *houseEstateInteractionButton;
@property (weak, nonatomic) IBOutlet UIButton *sellerButton;
@property (weak, nonatomic) IBOutlet UITableView *messageTableView;

@property (strong, nonatomic) UIStoryboardSegue *loginSegue;
@property (strong, nonatomic) UIStoryboardSegue *propertyServiceSegue;
@property (strong, nonatomic) UIStoryboardSegue *propertyFeeSegue;
@property (strong, nonatomic) UIStoryboardSegue *browseHouseEstateSegue;
@property (strong, nonatomic) UIStoryboardSegue *surroundingLifeSegue;

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
//    [_chooseHouseEstateBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], UITextAttributeFont: [UIFont fontAwesomeFontOfSize:18.0f]} forState:UIControlStateNormal];
    
    //登录Segue定义
    _loginSegue = [UIStoryboardSegue segueWithIdentifier:kLoginSegue
                                                            source:self
                                                       destination:[[UIStoryboard storyboardWithName:@"AccountManager" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"AccountManagerNavStoryboardID"]
                                                    performHandler:^{
                                                        [_loginSegue.sourceViewController presentViewController:_loginSegue.destinationViewController animated:YES completion:^{}];
                                                    }];
    
    //物业服务Segue定义
    _propertyServiceSegue = [UIStoryboardSegue segueWithIdentifier:kPropertyServiceSegue
                                                        source:self
                                                   destination:[[UIStoryboard storyboardWithName:@"PropertyService" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"PropertyServiceStoryboardID"]
                                                performHandler:^{
                                                    [((UIViewController *)(_propertyServiceSegue.sourceViewController)).navigationController pushViewController:_propertyServiceSegue.destinationViewController animated:YES];
                                                    ((UIViewController *)(_propertyServiceSegue.sourceViewController)).hidesBottomBarWhenPushed = YES;
                                                }];
    
    
    //物业缴费Segue定义
    _propertyFeeSegue = [UIStoryboardSegue segueWithIdentifier:kPropertyFeeSegue
                                                        source:self
                                                   destination:[[UIStoryboard storyboardWithName:@"PropertyFee" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"PropertyFeeStoryboardID"]
                                                performHandler:^{
                                                    [((UIViewController *)(_propertyFeeSegue.sourceViewController)).navigationController pushViewController:_propertyFeeSegue.destinationViewController animated:YES];
                                                    ((UIViewController *)(_propertyFeeSegue.sourceViewController)).hidesBottomBarWhenPushed = YES;
                                                }];
    
    //浏览小区Segue定义
    _browseHouseEstateSegue = [UIStoryboardSegue segueWithIdentifier:kBrowseHouseEstateSegue
                                                        source:self
                                                   destination:[[UIStoryboard storyboardWithName:@"BrowseHouseEstate" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"BrowseHouseEstateNavStoryboardID"]
                                                performHandler:^{
                                                    [_browseHouseEstateSegue.sourceViewController presentViewController:_browseHouseEstateSegue.destinationViewController animated:YES completion:^{}];
                                                }];
    
    //周边生活Segue定义
    _surroundingLifeSegue = [UIStoryboardSegue segueWithIdentifier:kSurroundingLifeSegue
                                                        source:self
                                                   destination:[[UIStoryboard storyboardWithName:@"SurroundingLife" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SurroundingLifeStoryboardID"]
                                                performHandler:^{
                                                    [((UIViewController *)(_surroundingLifeSegue.sourceViewController)).navigationController pushViewController:_surroundingLifeSegue.destinationViewController animated:YES];
                                                    ((UIViewController *)(_surroundingLifeSegue.sourceViewController)).hidesBottomBarWhenPushed = YES;
                                                }];
    
    
    if ([HXTAccountManager sharedInstance].defaultHouseingEstate) {
        _chooseHouseEstateBarButtonItem.title = [[HXTAccountManager sharedInstance].defaultHouseingEstate stringByAppendingString:@" ▾"];
    } else {
        _chooseHouseEstateBarButtonItem.title = @"全部商圈 ▾";
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[HXTAccountManager sharedInstance] addObserver:self
                                         forKeyPath:@"defaultHouseingEstate"
                                            options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                                            context:NULL];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [[HXTAccountManager sharedInstance] removeObserver:self forKeyPath:@"defaultHouseingEstate"];
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //从登录界面返回后进入物业服务页面
    if (_propertyServiceButton.selected && [HXTAccountManager sharedInstance].logged) {
        [_propertyServiceSegue perform];
    } else if (_propertyFeeButton.selected && [HXTAccountManager sharedInstance].logged) {
        [_propertyFeeSegue perform];
    }
    
    _propertyServiceButton.selected = NO;
    _propertyFeeButton.selected = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - key value abserver

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"defaultHouseingEstate"] && object == [HXTAccountManager sharedInstance]) {
        if ([HXTAccountManager sharedInstance].defaultHouseingEstate) {
            _chooseHouseEstateBarButtonItem.title = [[HXTAccountManager sharedInstance].defaultHouseingEstate stringByAppendingString:@" ▾"];
        } else {
            _chooseHouseEstateBarButtonItem.title = @"全部商圈 ▾";
        }
    }
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
        [_propertyServiceSegue perform];
        sender.selected = NO;
    } else {
        [_loginSegue perform];
    }
}

//物业缴费
- (IBAction)propertyFeeButtonPressed:(UIButton *)sender {
    sender.selected = YES;
    
    if ([HXTAccountManager sharedInstance].logged) {
        [_propertyFeeSegue perform];
        sender.selected = NO;
    } else {
        [_browseHouseEstateSegue perform];
    }
}

//周边生活
- (IBAction)surroundingLifeButtonPressed:(UIButton *)sender {
    sender.selected = YES;
    
    [_surroundingLifeSegue perform];
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
