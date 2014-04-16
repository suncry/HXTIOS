//
//  CYMyBillTableViewController.m
//  ButlerCard
//
//  Created by niko on 14-3-20.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import "CYMyBillTableViewController.h"
#import "CYMyBillMonthCell.h"
#import "CYMyBillDetailCell.h"
#import "SVPullToRefresh.h"

@interface CYMyBillTableViewController ()

@end

@implementation CYMyBillTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //消费单的假数据初始化
    _allDataArray = [[NSMutableArray alloc]initWithObjects:@[@"1月",@"香皂",@"洗面奶"],@[@"2月",@"杀虫剂"],nil];
    
    _dataArray = [[NSMutableArray alloc]initWithObjects:@[@"1月",@"香皂",@"洗面奶"],@[@"2月",@"杀虫剂"],nil];

    //注册下拉刷新功能
    __weak CYMyBillTableViewController *weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
    [weakSelf insertRowAtTop];
    }];
    //注册上拉刷新功能
    [self.tableView addInfiniteScrollingWithActionHandler:^{
    [weakSelf insertRowAtBottom];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSMutableArray *tempArray = _dataArray[section];
    return tempArray.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        //月份cell高度
        return 30.0;

    }
    else
    {
        //消费清单cell高度
        return 80.0;
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell...
    if (indexPath.row == 0)
    {
        CYMyBillMonthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYMyBillMonthCell" forIndexPath:indexPath];
        NSString *tempString = [NSString stringWithFormat:@"%@",_dataArray[indexPath.section][indexPath.row]];
        [cell.timeLable setText:tempString];
        return cell;
    }
    else
    {
        CYMyBillDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYMyBillDetailCell" forIndexPath:indexPath];
        NSString *tempString = [NSString stringWithFormat:@"%@",_dataArray[indexPath.section][indexPath.row]];
        [cell.titleLable setText:tempString];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    //点击的如果是月份cell  row == 0  则触发折叠功能
    if (indexPath.row == 0)
    {
        //折叠的情况
        if ([_dataArray[indexPath.section] count]> 1)
        {
            NSMutableArray *tempArray = [[NSMutableArray alloc]initWithObjects:_dataArray[indexPath.section][indexPath.row], nil];
            _dataArray[indexPath.section] = tempArray;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        }
        //展开的情况
        else
        {
            _dataArray[indexPath.section] = _allDataArray[indexPath.section];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}
#pragma mark --SVPullToRefresh--
//下拉刷新
- (void)insertRowAtTop
{
    //为了模拟加载数据的过程 设置方法延迟2秒执行
    // 延迟2秒执行：
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        _allDataArray = [[NSMutableArray alloc]initWithObjects:@[@"1月",@"香皂",@"洗面奶"],@[@"2月",@"杀虫剂"],@[@"2月",@"杀虫剂"],nil];
        _dataArray = [[NSMutableArray alloc]initWithObjects:@[@"1月",@"香皂",@"洗面奶"],@[@"2月",@"杀虫剂"],@[@"2月",@"杀虫剂"],nil];
        [self.tableView reloadData];
        //停止刷新
        [self.tableView.pullToRefreshView stopAnimating];
    });
}
//上拉加载更多
- (void)insertRowAtBottom
{
    //为了模拟加载数据的过程 设置方法延迟2秒执行
    // 延迟2秒执行：
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [_allDataArray addObjectsFromArray:[NSArray arrayWithObjects:@[@"x月",@"杀虫剂"],@[@"y月",@"香皂",@"洗面奶"],@[@"z月",@"杀虫剂"],nil]];
        [_dataArray addObjectsFromArray:[NSArray arrayWithObjects:@[@"x月",@"杀虫剂"],@[@"y月",@"香皂",@"洗面奶"],@[@"z月",@"杀虫剂"],nil]];
        [self.tableView reloadData];
        //停止加载更多
        [self.tableView.infiniteScrollingView stopAnimating];
    });
}

@end
