//
//  CYPropertieCardsController.m
//  ButlerCard
//
//  Created by niko on 14-4-21.
//  Copyright (c) 2014年 johnny. All rights reserved.
//

#import "CYPropertieCardsController.h"
#import "SVPullToRefresh.h"

@interface CYPropertieCardsController ()

@end

@implementation CYPropertieCardsController

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
    
    //消费单的假数据初始化
    _allDataArray = [[NSMutableArray alloc]initWithObjects:@[@"1月",@"香皂",@"洗面奶"],@[@"2月",@"杀虫剂"],nil];
    
    _dataArray = [[NSMutableArray alloc]initWithObjects:@[@"1月",@"香皂",@"洗面奶"],@[@"2月",@"杀虫剂"],nil];
    
    //注册下拉刷新功能
    __weak CYPropertieCardsController *weakSelf = self;
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
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *tempArray = _dataArray[section];
    return tempArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        //月份cell高度
        return 44.0;
        
    }
    else
    {
        //消费清单cell高度
        return 80.0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myPropertyCardCellIdentifier" forIndexPath:indexPath];
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myPropertyCardCommentCellIdentifie" forIndexPath:indexPath];
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
