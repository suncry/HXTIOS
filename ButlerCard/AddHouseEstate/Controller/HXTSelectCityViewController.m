//
//  HXTSelectCityViewController.m
//  ButlerCard
//
//  Created by johnny tang on 3/6/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTSelectCityViewController.h"
#import "HXTAccountManager.h"
#import "HXTLocationManager.h"
#import "HXTAreaModel.h"


@interface HXTSelectCityViewController () <HXTAreaModelDelegate>

@property (strong, nonatomic) HXTAreaModel *areaModel;
@property (copy  , nonatomic) NSString     *currentArea;

@end

@implementation HXTSelectCityViewController

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
    
    _areaModel = [[HXTAreaModel alloc] init];
    _areaModel.delegate = self;

    _currentArea = [HXTAccountManager sharedInstance].currentArea;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_areaModel reloadAreasFromServer];
    [self _updateCurrentAare];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    
    return _areaModel.area.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    } else {
        NSArray *oneLevelArea = _areaModel.area.allKeys;
        NSArray *twoLevelArea = _areaModel.area[oneLevelArea[section - 1]];
        return twoLevelArea.count;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"当前位置";
    } else {
        NSArray *keys = _areaModel.area.allKeys;
        return keys[section - 1];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"CurrentAreaCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        
        cell.textLabel.text = _currentArea;
        
        return cell;
    } else  {
        static NSString *CellIdentifier = @"AreaCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        
        NSArray *keys = _areaModel.area.allKeys;
        cell.textLabel.text = _areaModel.area[keys[indexPath.section - 1]][indexPath.row][@"area"];
        
        return cell;
    }
}

#pragma mark - AreaModel Delegate

- (void)areaModel:(HXTAreaModel *)areaModel DidFinishLoadingArea:(NSDictionary *)area {
    [self.tableView reloadData];
}

- (void)areaModel:(HXTAreaModel *)areaModel DidFailLoadingAreaWithError:(NSError *)error {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                       message:error.description
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles: nil];
    [alertView show];
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            if (_currentArea && ![_currentArea isEqualToString:[HXTAccountManager sharedInstance].currentArea]) {
                [HXTAccountManager sharedInstance].currentArea = _currentArea;
            }
        }];
        
    } else {
        
        NSArray *keys = _areaModel.area.allKeys;
        _currentArea = _areaModel.area[keys[indexPath.section - 1]][indexPath.row][@"area"];
        
        [self dismissViewControllerAnimated:YES completion:^{
            if (_currentArea && ![_currentArea isEqualToString:[HXTAccountManager sharedInstance].currentArea]) {
                [HXTAccountManager sharedInstance].currentArea = _currentArea;
            }
        }];
    }
}


#pragma mark - local functions

- (void)_updateCurrentAare {
    //获得当前区域
    __block __weak HXTSelectCityViewController *selectCityViewController = self;
    
    [[HXTLocationManager sharedLocation] getSubLocality:^(NSString *subLocality) {
        if (subLocality && subLocality.length > 0 && ![subLocality isEqualToString:_currentArea]) {
            selectCityViewController.currentArea = subLocality;
            
            [HXTAccountManager sharedInstance].currentArea = subLocality;
            // Update Tabel View
            dispatch_async(dispatch_get_main_queue(), ^{
                NSIndexSet *indexSet= [NSIndexSet indexSetWithIndex:0];
                [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            });
        }
    }];
}

#pragma mark - Navigation

- (IBAction)backButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
