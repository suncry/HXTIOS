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

typedef NS_ENUM(NSUInteger, sectionType) {
    sectionTypeCurrentCity = 0,
    sectionTypeTopCities,
    sectionTypeProvinces
};

@interface HXTSelectCityViewController () <HXTAreaModelDelegate>

@property (strong, nonatomic) HXTAreaModel *areaModel;
@property (copy  , nonatomic) NSString     *currentCity;

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
    
    _currentCity = [HXTAccountManager sharedInstance].currentCity;
    
    //获得当前城市
    __block __weak HXTSelectCityViewController *selectCityViewController = self;
    [[HXTLocationManager sharedLocation] getCity:^(NSString *cityString) {
        if (cityString && cityString.length > 0 && ![cityString isEqualToString:_currentCity]) {
            selectCityViewController.currentCity = cityString;
            
            // Update Tabel View
            dispatch_async(dispatch_get_main_queue(), ^{
                NSIndexSet *indexSet= [NSIndexSet indexSetWithIndex:0];
                [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            });
        }
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
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
        NSArray *keys = _areaModel.area.allKeys;
        return [_areaModel.area[keys[section]] count];
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
        
        cell.textLabel.text = _currentCity;
        
        return cell;
    } else  {
        static NSString *CellIdentifier = @"AreaCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        
        return cell;
    }
}

#pragma mark - AreaModel Delegate

- (void)areaModel:(HXTAreaModel *)areaModel DidFinishLoadingArea:(NSDictionary *)area {
    NSLog(@"area = %@", area);
    
}

- (void)areaModel:(HXTAreaModel *)areaModel DidFailLoadingAreaWithError:(NSError *)error {
    NSLog(@"error = %@", error);
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (tableView == self.tableView) {
//        if (indexPath.section == sectionTypeCurrentCity) {
//            
//            [self dismissViewControllerAnimated:YES completion:^{
//                if (_currentCity && ![_currentCity isEqualToString:[HXTAccountManager sharedInstance].currentCity]) {
//                    [HXTAccountManager sharedInstance].currentCity = _currentCity;
//                }
//            }];
//            
//        } else if (indexPath.section == sectionTypeTopCities) {
//            _currentCity = _topCities[indexPath.row];
//            
//            [self dismissViewControllerAnimated:YES completion:^{
//                if (_currentCity && ![_currentCity isEqualToString:[HXTAccountManager sharedInstance].currentCity]) {
//                    [HXTAccountManager sharedInstance].currentCity = _currentCity;
//                }
//            }];
//        } else if (indexPath.section == sectionTypeProvinces) {
//           ;
//        } else {
//            NSLog(@"####Error%s %s %d %@", __FILE__, __FUNCTION__, __LINE__, @"Wrong indexPath.section");
//        }
//    } else { // _selectCitySecondLevelViewController.tableView
//        if (_selectCitySecondLevelViewController) {
//            [_selectCitySecondLevelViewController dismissViewControllerAnimated:YES completion:^{
//                NSString *key = [NSString stringWithFormat:@"%li", (long)indexPath.row];
//                NSDictionary *city = _selectedProvince[key];
//                [HXTAccountManager sharedInstance].currentCity = city.allKeys[0];
//            }];
//        }
//    }
}

#pragma mark - IB Actions

- (IBAction)backButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    if ([segue.identifier isEqualToString:@"SelectCitySecondLevelSegueIdentifier"]) {
//        
//        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
//        
//        if (selectedIndexPath.section == sectionTypeProvinces) {
//            
//            _selectCitySecondLevelViewController = segue.destinationViewController;
//            
//            //设置Title为所选择的省份
//            NSString *key = [NSString stringWithFormat:@"%li", (long)selectedIndexPath.row];
//            NSDictionary *province = _provinces[key];
//            _selectCitySecondLevelViewController.navigationItem.title  = province.allKeys[0];
//            
//            //获取当前省份城市数据。
//            key = [NSString stringWithFormat:@"%li", (long)selectedIndexPath.row];
//            NSDictionary *provinceWithIndex = _provinces[key];
//            _selectedProvince = provinceWithIndex[provinceWithIndex.allKeys[0]];
//            
//            // Set _selectCitySecondLevelViewController.tableView.delegate to self
//            [segue.destinationViewController setValue:self forKeyPath:@"self.tableView.delegate"];
//            
//            // Set _selectCitySecondLevelViewController.tableView.dataSource to self
//            [segue.destinationViewController setValue:self forKeyPath:@"self.tableView.dataSource"];
//        }
//    }
//}


@end
