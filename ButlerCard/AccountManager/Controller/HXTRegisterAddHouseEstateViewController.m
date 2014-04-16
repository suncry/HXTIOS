//
//  HXTRegisterAddHouseEstateViewController.m
//  ButlerCard
//
//  Created by johnny tang on 3/31/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTRegisterAddHouseEstateViewController.h"
#import "HXTAddHouseViewController.h"
#import "HXTAccountManager.h"
#import "MBProgressHUD.h"

@interface HXTRegisterAddHouseEstateViewController () <UITableViewDelegate, UITableViewDataSource, MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UITableView *houseEstateTableView;

@property (strong, nonatomic) NSMutableArray *willAddedhouseEstates;
@property (strong, nonatomic) MBProgressHUD *HUD;
@end

@implementation HXTRegisterAddHouseEstateViewController

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
    _willAddedhouseEstates = [NSMutableArray arrayWithArray:@[@"中铁小区 1栋2单元302", @"广都小区 1栋2单元302"]];
    
    NSLog(@"username = %@, password = %@", _accountManager.username, _accountManager.password);
    NSLog(@"logged = %@", [HXTAccountManager sharedInstance].logged ? @"YES": @"NO");
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(addHouseNotificationSelector:)
                                                 name:kAddHouseNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(registeredAndloginNotificationSelector:)
                                                 name:kRegisteredAndLoginSuccessNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(registeredAndloginNotificationSelector:)
                                                 name:kRegisteredAndLoginFailedNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - notification abserver

- (void)addHouseNotificationSelector:(NSNotification *)notification {
    
    if (notification.object != self && [notification.name isEqualToString:kAddHouseNotification]) {
        NSLog(@"22notification.userInfo = %@", notification.userInfo);
        NSString *houseEetateName = notification.userInfo[kHouseEstateName];
        NSUInteger buildingNo = [notification.userInfo[kBuildingNo] unsignedIntegerValue];
        NSUInteger unitNo = [notification.userInfo[kUnitNo] unsignedIntegerValue];
        NSUInteger houseNo = [notification.userInfo[kHouseNo] unsignedIntegerValue];
        NSString *houseString = [NSString stringWithFormat:@"%@ %lu栋%lu单元%lu", houseEetateName, (long)buildingNo, (long)unitNo, (long)houseNo];
        [_willAddedhouseEstates  addObject:houseString];
        
        [_houseEstateTableView reloadData];
    }
}

- (void)registeredAndloginNotificationSelector:(NSNotification *)notification {
    [_HUD hide:YES];
    NSLog(@"notification.name = %@", notification.name);
    
    if ([notification.name isEqualToString:kRegisteredAndLoginSuccessNotification]) {
        if (self.navigationController.viewControllers.count > 5) { //其他Controller通过导航控制器进入该页面
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else { //使用的模态方式进入改页面
            [self dismissViewControllerAnimated:NO completion:^{}];
        }
        //        [self.navigationController popToRootViewControllerAnimated:YES];
    } else if ([notification.name isEqualToString:kRegisteredAndLoginFailedNotification]) {
        if (notification.userInfo) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"注册失败"
                                                                message:notification.userInfo[@"NSLocalizedDescription"]
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }
}

#pragma mark - table View dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _willAddedhouseEstates.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *houseEstateCellIdentifier = @"HouseEstateCellIdentifier";
    static NSString *RegisterCellIdentifer = @"RegisterCellIdentifer";
    
    if (indexPath.row < _willAddedhouseEstates.count) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:houseEstateCellIdentifier forIndexPath:indexPath];
        //        cell.textLabel.textColor = [UIColor colorWithWhite:0.3f alpha:1];
        //        cell.textLabel.font = [UIFont systemFontOfSize:15];
        //        cell.textLabel.text = _willAddedhouseEstates[indexPath.row];
        
        ((UILabel *)[cell viewWithTag:101]).text = _willAddedhouseEstates[indexPath.row];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RegisterCellIdentifer forIndexPath:indexPath];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0;
}


#pragma mark - table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _willAddedhouseEstates.count) {
        return 40;
    } else {
        return 84;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 40.0f)];
    headerView.backgroundColor = [UIColor colorWithWhite:241.0f / 255.0f alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 300.0f, 20.0f)];
    [headerView addSubview:label];
    
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor colorWithWhite:156.0f / 255 alpha:1];
    label.text = @"添加小区后可以使用物业社区服务及相关配送功能";
    
    return headerView;
}

#pragma mark - MBProgressHUD Delegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[_HUD removeFromSuperview];
}

#pragma mark - IB Actions

- (IBAction)registerButtonPressed:(id)sender {
    
    if (!_HUD) {
        _HUD = [[MBProgressHUD alloc] initWithView:self.view.window];
    }
    [self.view.window addSubview:_HUD];
    
    _HUD.delegate = self;
    _HUD.labelText = @"注册...";
    [_HUD show:YES];
    [[HXTAccountManager sharedInstance] registerAndLoginAccountWithUsername:self.accountManager.username password:self.accountManager.password];
//    if (self.navigationController.viewControllers.count > 5) { //其他Controller通过导航控制器进入该页面
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    } else { //使用的模态方式进入改页面
//        [self dismissViewControllerAnimated:YES completion:^{}];
//    }
}

- (IBAction)addHouseEstateButtonPressed:(id)sender {
    NSLog(@"添加小区");
    
    UIViewController * addHouseEstateNavViewController = [[UIStoryboard storyboardWithName:@"AddHouseEstate" bundle:nil] instantiateViewControllerWithIdentifier:@"AddHouseEstateNavStoryboardID"];
    [self presentViewController:addHouseEstateNavViewController animated:YES completion:^{}];
    
}

- (IBAction)delHouseEstateButtonPressed:(UIButton *)sender {
    
    UIView *view = sender.superview;
    
    while (view && view.superview) {
        if ([view isKindOfClass:[UITableViewCell class]]) {
            NSIndexPath *indexPath = [_houseEstateTableView indexPathForCell:(UITableViewCell *)view];
            [_willAddedhouseEstates removeObjectAtIndex:indexPath.row];
            [_houseEstateTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            return;
        }
        
        view = view.superview;
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
