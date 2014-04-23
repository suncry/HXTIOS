//
//  HXTPropertyFeeViewController.m
//  ButlerCard
//
//  Created by johnny tang on 3/10/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTPropertyFeeViewController.h"
#import "HXTPropertyTableViewHeaderFooterView.h"
#import "HXTMyProperties.h"
#import "HXTAccountManager.h"

#define kHeaderFooterViewReuseIdentifier @"HeaderFooterViewReuseIdentifier"

@interface HXTPropertyFeeViewController () <HXTPropertyTableViewHeaderFooterViewDelegate>

@property (strong, nonatomic) NSMutableIndexSet *expandedIndexSet;
@property (strong, nonatomic) NSArray *freeNames;

@end

@implementation HXTPropertyFeeViewController

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
    [self.tableView registerNib:[UINib nibWithNibName:@"MyPropertyTableViewHeaderFooterView" bundle:[NSBundle mainBundle]]forHeaderFooterViewReuseIdentifier:kHeaderFooterViewReuseIdentifier];
    
    _expandedIndexSet = [NSMutableIndexSet indexSetWithIndex:0];
    _freeNames = @[@"物管费", @"停车费", @"水费", @"电费", @"气费",@"物管费", @"停车费", @"水费", @"电费", @"气费"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [HXTMyProperties sharedInstance].properties.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_expandedIndexSet containsIndex:section]) {
        HXTPropertyCell *property = [HXTMyProperties sharedInstance].properties[section];
        return property.fees.count + 1; //计算功能行
    } else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ProtertyItemDetailCellIdentifier = @"ProtertyItemDetailCellIdentifier"; //详情单元
    static NSString *FunctionCellIdentifier           = @"FunctionCellIdentifier";           //功能单元
    
    HXTPropertyCell *property = [HXTMyProperties sharedInstance].properties[indexPath.section];
    if (indexPath.row < property.fees.count) { //详情单元
        HXTPropertyFeeCell *feeCell = property.fees[indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemDetailCellIdentifier forIndexPath:indexPath];
//        ((UILabel *)[cell viewWithTag:101]).text = _freeNames[feeCell.freeType];
        ((UILabel *)[cell viewWithTag:101]).text = _freeNames[indexPath.row];
        
        NSDateFormatter *df  = [[NSDateFormatter alloc] init];
        [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [df setDateFormat:@"YYYY年MM月d日"];
        ((UILabel *)[cell viewWithTag:102]).text = [NSString stringWithFormat:@"截止%@", [df stringFromDate:feeCell.deadline]];
//        ((UILabel *)[cell viewWithTag:103]).text = [NSString stringWithFormat:@"%.2f", feeCell.money];
        return cell;
    } else if (indexPath.row == property.fees.count) { //功能单元
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FunctionCellIdentifier forIndexPath:indexPath];
        return cell;
    } else {
        NSLog(@"Error##############%s %s %d Wrong indexPath!!!", __FILE__, __FUNCTION__, __LINE__);
        return nil;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    HXTPropertyTableViewHeaderFooterView *tableViewHeaderFooterView = (HXTPropertyTableViewHeaderFooterView *)[tableView headerViewForSection:section];
    tableViewHeaderFooterView.tag = section;
    
    //设置Header显示小区地址
    HXTPropertyCell *property = [HXTMyProperties sharedInstance].properties[section];
    UILabel *label = (UILabel *)[tableViewHeaderFooterView viewWithTag:103];
    label.text = [NSString stringWithFormat:@"%@ %li栋%li单元%li", property.house.housingEstatename, (long)property.house.buildingNo, (long)property.house.unitNo, (long)property.house.houseNo];
    
    if ([_expandedIndexSet containsIndex:tableViewHeaderFooterView.tag]) {
        tableViewHeaderFooterView.expanded = YES;
    } else {
        tableViewHeaderFooterView.expanded = NO;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HXTPropertyTableViewHeaderFooterView *tableViewHeaderFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderFooterViewReuseIdentifier];
    tableViewHeaderFooterView.delegate = self;
    tableViewHeaderFooterView.tag = section;
    
    //设置Header显示小区图片及地址
    HXTPropertyCell *property = [HXTMyProperties sharedInstance].properties[section];
    tableViewHeaderFooterView.titleLabel.text = [NSString stringWithFormat:@"%@ %li栋%li单元%li", property.house.housingEstatename, (long)property.house.buildingNo, (long)property.house.unitNo, (long)property.house.houseNo];
    tableViewHeaderFooterView.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"property_house%lu", (long)(section % 7 + 1)]];
    
    if ([_expandedIndexSet containsIndex:tableViewHeaderFooterView.tag]) {
        tableViewHeaderFooterView.expanded = YES;
    } else {
        tableViewHeaderFooterView.expanded = NO;
    }
    
    return tableViewHeaderFooterView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < 5) {
        return 44;
    } else {
        return 148;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



#pragma mark - HXTPropertyTableViewHeaderFooterView Delegate

-(void)HXTPropertyTableViewHeaderFooterView:(HXTPropertyTableViewHeaderFooterView *)tableViewHeaderFooterView expanded:(BOOL)expanded{
    
    if (expanded) {
        NSIndexSet *lastIndexSet = [[NSIndexSet alloc] initWithIndexSet:_expandedIndexSet];
        [_expandedIndexSet addIndex:tableViewHeaderFooterView.tag];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:tableViewHeaderFooterView.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
        if (lastIndexSet.count > 0) {
            [_expandedIndexSet removeIndexes:lastIndexSet];
            [self.tableView reloadSections:lastIndexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    } else {
        [_expandedIndexSet removeIndex:tableViewHeaderFooterView.tag];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:tableViewHeaderFooterView.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


-(void)HXTPropertyTableViewHeaderFooterView:(HXTPropertyTableViewHeaderFooterView *)tableViewHeaderFooterView ApplyPropertyService:(BOOL)apply {
    UIViewController *propertyServiceViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PropertyServiceStoryboardID"];
    [self.navigationController pushViewController:propertyServiceViewController animated:YES];
}

#pragma mark - IB Actions

- (IBAction)addPropertyButtonPressed:(id)sender {
    NSLog(@"添加物业");
    UIViewController *addHouseEstateNavViewController = [[UIStoryboard storyboardWithName:@"AddHouseEstate" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"AddHouseEstateNavStoryboardID"];
    [self presentViewController:addHouseEstateNavViewController animated:YES completion:^{}];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"segue.indentifer = %@", segue.identifier );
    if ([segue.identifier isEqualToString:@"ChooseCityStoryboardID"]) {
        //模态显示动画
        //        ((UIViewController *)segue.destinationViewController).modalPresentationStyle = UIModalPresentationPageSheet;
        //        ((UIViewController *)segue.destinationViewController).modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    } else if ([segue.identifier isEqualToString:@"PropertyFeeDetailStoryboardSegue"]) { //费用明细
        ((UIViewController *)(segue.destinationViewController)).hidesBottomBarWhenPushed = YES;
    } else if ([segue.identifier isEqualToString:@"BindCardStoryboardSegue"]) {    //绑定卡
        ((UIViewController *)(segue.destinationViewController)).hidesBottomBarWhenPushed = YES;
    } else if ([segue.identifier isEqualToString:@"RechargeStoryboardSegue"]) {    //充值
        ((UIViewController *)(segue.destinationViewController)).hidesBottomBarWhenPushed = YES;
    } else if ([segue.identifier isEqualToString:@"WithholdingStoryboardSegue"]) { //代扣
        ((UIViewController *)(segue.destinationViewController)).hidesBottomBarWhenPushed = YES;
    }
    
}

@end
