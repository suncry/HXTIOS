//
//  CYShopController.m
//  ButlerCard
//
//  Created by niko on 14-4-24.
//  Copyright (c) 2014年 johnny. All rights reserved.
//

#import "CYShopController.h"
#import "SVPullToRefresh.h"
#import "AFNetworking.h"
#import "DJQRateView.h"
#import "Shop.h"

@interface CYShopController ()

@end

@implementation CYShopController

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
    [self queryFromDB];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //注册上拉刷新功能
    __weak CYShopController *weakSelf = self;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertRowAtBottom];
    }];
    
    //获取当前应用程序的委托（UIApplication sharedApplication为整个应用程序上下文）
    self.myDelegate = (HXTAppDelegate *)[[UIApplication sharedApplication] delegate];

    //获取评论数量
    [self commentNum];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 34;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"商家动态";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"saleMsgCell" forIndexPath:indexPath];
    return cell;
}
- (IBAction)takeCall:(id)sender
{
    NSString *number = [[NSUserDefaults standardUserDefaults] valueForKey:kShopTel];// 此处读入电话号码
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
}
#pragma mark --SVPullToRefresh--
//上拉加载更多
- (void)insertRowAtBottom
{
    //接口空缺
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"tenement_id": @"1",
                                 @"type": @"0",
                                 @"canSend": @"0",
                                 @"candPayoff": @"0",
                                 @"size": @"6",
                                 @"offset": @"0",
                                 @"sid": @"66d804a0bb4c0a06",};
    [manager POST:@"http://bbs.enveesoft.com:1602/htx/hexinpassserver/appserver/public/store/list" parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         _dataArr = [responseObject valueForKey:@"results"];
         [self.tableView reloadData];
         //         NSLog(@"self.dataDic: %@", _dataArr);
         NSLog(@"下拉加载更多！");
         //停止刷新
         [self.tableView.infiniteScrollingView stopAnimating];
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}
- (void)queryFromDB
{
    //创建取回数据请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //设置要检索哪种类型的实体对象
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Shop"inManagedObjectContext:self.myDelegate.managedObjectContext];
    //设置请求实体
    [request setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(shopID = %@)",[[NSUserDefaults standardUserDefaults]valueForKey:kShopID]];
    [request setPredicate:predicate];
    NSError *error = nil;
    //执行获取数据请求，返回数组
    NSMutableArray *mutableFetchResult = [[self.myDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult == nil)
    {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }
    NSLog(@"The count of FetchResult:%lu",(unsigned long)[mutableFetchResult count]);
    for(Shop *entry in mutableFetchResult)
    {
//        NSLog(@"Shop ------>  grade:%@",entry.grade);
        [_rateView setRate:[entry.grade floatValue]];
        [[NSUserDefaults standardUserDefaults]setValue:entry.tel forKey:kShopTel];
        [_telBtn setTitle:entry.tel forState:UIControlStateNormal];
        self.navigationItem.title = entry.name;
    }

}
- (void)commentNum
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"store_id": [[NSUserDefaults standardUserDefaults]valueForKey:kShopID]};
    [manager POST:@"http://bbs.enveesoft.com:1602/htx/hexinpassserver/appserver/public/store/info" parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
//         _dataArr = (responseObject[@"results"])[@"comments"];
//         [(UIButton *)[self.view viewWithTag:105] setText:[NSString stringWithFormat:@"%d",((NSArray *)(responseObject[@"results"])[@"comments"]).count]];
         [(UIButton *)[self.view viewWithTag:105] setTitle:[NSString stringWithFormat:@"用户评价(%d)",((NSArray *)(responseObject[@"results"])[@"comments"]).count] forState:UIControlStateNormal];
//         NSLog(@"评论数量为 == %@",[NSString stringWithFormat:@"%d",((NSArray *)(responseObject[@"results"])[@"comments"]).count]);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"获取评论数量失败Error: %@", error);
     }];

}
@end
