//
//  HXTAddHouseEstateViewController.m
//  ButlerCard
//
//  Created by johnny tang on 2/21/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTAddHouseEstateViewController.h"
#import "HXTAccountManager.h"
#import "HXTHouseEstateListModel.h"
#import "HXTAddHousePickerView.h"
#import "HXTHouseListModel.h"
#import "HXTAddHouseEstateModel.h"
#import "MBProgressHUD.h"


@interface HXTAddHouseEstateViewController ()
<
HXTHouseEstateListModelDelegate,
MBProgressHUDDelegate,
HXTHouseListModelDelegate,
HXTAddHouseEstateModelDelegate,
HXTAddHousePickerViewDelegate
>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *chooseAreaBarButtonItem;
@property (weak, nonatomic) IBOutlet UIControl *coverView;
@property (weak, nonatomic) IBOutlet UISearchBar *propertySearchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) HXTAddHousePickerView *addHousePickerView;
@property (strong, nonatomic) HXTHouseEstateListModel *houseEstatelistModel;
@property (strong, nonatomic) NSArray *houstEstateList;
@property (strong, nonatomic) HXTHouseListModel *houstListModel;
@property (strong, nonatomic) HXTAddHouseEstateModel *addHouseEstateModel;
@property (strong, nonatomic) MBProgressHUD *HUD;

@end

@implementation HXTAddHouseEstateViewController

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
    
    
    _houseEstatelistModel = [[HXTHouseEstateListModel alloc] init];
    _houseEstatelistModel.delegate = self;
    
    _houstListModel = [[HXTHouseListModel alloc] init];
    _houstListModel.delegate = self;
    
    _addHousePickerView = [[[NSBundle mainBundle] loadNibNamed:@"HXTAddHousePickerView" owner:self options:nil] lastObject];
    _addHousePickerView.delegate = self;
    
    
    _chooseAreaBarButtonItem.title = [[HXTAccountManager sharedInstance].currentArea stringByAppendingString:@" ▾"];
    
    if ([self.functionType integerValue] == FunctionTypeBrowHouseEstate) {
        self.title = @"浏览小区";
    } else {
        self.title = @"添加小区";
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[HXTAccountManager sharedInstance] addObserver:self
                                         forKeyPath:@"currentArea"
                                            options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                                            context:NULL];
}

- (void)viewWillDisappear:(BOOL)animated {
    [_propertySearchBar resignFirstResponder];
    [[HXTAccountManager sharedInstance] removeObserver:self forKeyPath:@"currentArea"];
    
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!_HUD) {
        _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    }
    [self.view addSubview:_HUD];
    
    _HUD.delegate = self;
    [_HUD show:YES];
    
    [_houseEstatelistModel loadDataFromServerWithAreaID:nil andSearchWord:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - key value abserver

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"currentArea"] && object == [HXTAccountManager sharedInstance]) {
        _chooseAreaBarButtonItem.title = [[HXTAccountManager sharedInstance].currentArea stringByAppendingString:@" ▾"];
    }
}

#pragma mark - UISearchBar Delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.view bringSubviewToFront:_coverView];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"1searchBar.text = %@ searchText = %@", searchBar.text, searchText);
    [self startSearch:searchBar.text];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self.view sendSubviewToBack:_coverView];
    NSLog(@"3searchBar.text = %@", searchBar.text);
}

- (void)startSearch:(NSString *)searchString {
    if (searchString == nil || (id)searchString==[NSNull null] ||
        searchString.length <= 0 || [searchString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length<=0) {
        //未输入查询，不做处理
    } else {
        [_houseEstatelistModel loadDataFromServerWithAreaID:nil andSearchWord:searchString];
    }
    
    [_collectionView reloadData];
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _houstEstateList.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *collectionViewCellIdentifier= @"CollectionViewCellIdentifier";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];
    ((UIImageView *)[cell viewWithTag:100]).image = [UIImage imageNamed:[NSString stringWithFormat:@"property_house%lu", (long)(indexPath.row % 7 + 1)]];
    ((UILabel *)[cell viewWithTag:101]).text = _houstEstateList[indexPath.row][@"name"];
    
    return cell;
}


#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectItemAtIndexPath indexPath.section = %li, indexPath.row = %li", (long)indexPath.section, (long)indexPath.row);
    
    if ([self.functionType integerValue] == FunctionTypeBrowHouseEstate) { //是浏览小区页面
        UIViewController *loginViewcontroller = [[UIStoryboard storyboardWithName:@"AccountManager" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginStoryboardID"];
        
        [self.navigationController pushViewController:loginViewcontroller animated:YES];
    } else { //是添加小区页面
        _addHousePickerView.titleLabel.text = _houstEstateList[indexPath.row][@"name"];
        [_houstListModel loadDataFromServerWithHouseEstateID:@"1"];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - HXTHouseEstateListModel Delegate

- (void)houseEstateListModel:(HXTHouseEstateListModel *)houseEstateListModel DidFinishLoadingListModel:(NSArray *)houseEstateList {
    _houstEstateList = houseEstateList;
    [_collectionView reloadData];
    [_HUD hide:YES];
}

- (void)houseEstateListModel:(HXTHouseEstateListModel *)houseEstateListModel DidFailLoadingListModelWithError:(NSError *)error {
    NSLog(@"%s %s %d Error: %@", __FILE__, __FUNCTION__, __LINE__, error.description);
    
    [_HUD hide:YES];
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:nil message:error.localizedDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alerView show];
}

#pragma mark - HXTHouseListModel Delegate

- (void)houseListModel:(HXTHouseListModel *)houseListModel DidFinishLoadingListModel:(NSDictionary *)houseList {
    _addHousePickerView.houseList = houseList;
    [_addHousePickerView show];
}
- (void)houseListModel:(HXTHouseListModel *)houseListModel DidFailLoadingListModelWithError:(NSError *)error {
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:nil
                                                       message:error.description
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
    [alerView show];
}

#pragma mark - HXTAddHousePickerView Delegate

- (void)addHousePickerViewDidSelectHouseWithBuildingNo:(NSString *)buildingNo unitNo:(NSString *)unitNo houseNo:(NSString *)houseNo {
    NSLog(@"addHousePickerViewDidSelectHouseWithBuildingNo = %@, unitNo = %@, houseNo = %@", buildingNo, unitNo, houseNo);
    if (!_addHouseEstateModel) {
        _addHouseEstateModel = [[HXTAddHouseEstateModel alloc] init];
        _addHouseEstateModel.delegate = self;
    }
    
    [_addHouseEstateModel addHouseEstateToServerWithUserID:@"1" houseEstateID:@"1" buildingNo:buildingNo unitNo:unitNo houseNo:houseNo];
}

- (void)addHousePickerViewDidPressCancel {
    NSLog(@"addHousePickerViewDidPressCancel");
}

#pragma mark - HXTAddHouseEstateModel Delegate

- (void)addHouseEstateModel:(HXTAddHouseEstateModel *)addHouseEstateModel DidFinishAddHouseEstate:(NSDictionary *)houseEstate {
    
    NSLog(@"houseEstate = %@", houseEstate);
}

- (void)addHouseEstateModel:(HXTAddHouseEstateModel *)addHouseEstateModel DidFailAddHouseEstateWithError:(NSError *)error {
    
}

#pragma mark - MBProgressHUD Delegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[_HUD removeFromSuperview];
}

#pragma mark - IB Actions

- (IBAction)backgroudTouchUpInside:(id)sender {
    [_propertySearchBar resignFirstResponder];
    [self.view sendSubviewToBack:_coverView];
}

- (IBAction)appleyOpenPropertyButtonPressed:(id)sender {
    NSLog(@"appleyOpenPropertyButtonPressed");
}

#pragma mark - Navigation


- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
