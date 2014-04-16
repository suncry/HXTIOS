//
//  CYActivityViewController.m
//  ButlerCard
//
//  Created by niko on 14-3-25.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import "CYActivityViewController.h"
#import "CYActivityCell.h"
#import "SVPullToRefresh.h"
@interface CYActivityViewController ()

@end

@implementation CYActivityViewController

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
    //注册下拉刷新功能
    __weak CYActivityViewController *weakSelf = self;
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 3;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self.tableView registerClass:[CYActivityCell class] forCellReuseIdentifier:@"CYActivityCell"];
    // Configure the cell...
    CYActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYActivityCell" forIndexPath:indexPath];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
#pragma mark --SVPullToRefresh--
//下拉刷新
- (void)insertRowAtTop
{
    //为了模拟加载数据的过程 设置方法延迟2秒执行
    // 延迟2秒执行：
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                   {
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
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                   {
                       //停止加载更多
                       [self.tableView.infiniteScrollingView stopAnimating];
                   });
}
#pragma mark --segmentValueChanged--
- (IBAction)segmentValueChange:(UISegmentedControl *)sender
{
//    NSLog(@"segmentIndex == %d",sender.selectedSegmentIndex);
    //我的参与
    if (sender.selectedSegmentIndex == 0)
    {
        [self.tableView triggerPullToRefresh];
    }
    //我的发起
    else
    {
        [self.tableView triggerPullToRefresh];
    }
    
}
@end
