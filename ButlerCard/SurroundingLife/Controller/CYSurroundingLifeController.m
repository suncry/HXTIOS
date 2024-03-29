//
//  CYSurroundingLifeController.m
//  ButlerCard
//
//  Created by niko on 14-4-22.
//  Copyright (c) 2014年 johnny. All rights reserved.
//

#import "CYSurroundingLifeController.h"
#import "PCStackMenu.h"
#import "searchCell.h"
#import "DJQRateView.h"
#import "AFNetworking.h"
#import "SVPullToRefresh.h"
#import "Shop.h"

@interface CYSurroundingLifeController ()

@end

@implementation CYSurroundingLifeController
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
    //每次进入页面都根据所选择住址刷新一遍页面内容
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    [HUD showWhileExecuting:@selector(insertRowAtTop) onTarget:self withObject:nil animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    _cySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 100, 320, 44)];
    _cySearchBar.hidden = YES;
    _cySearchBar.delegate = self;
    [self.view addSubview:_cySearchBar];
    _cySearchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:_cySearchBar contentsController:self];
    _cySearchDisplayController.delegate = self;
    _cySearchDisplayController.searchResultsDelegate = self;
    _cySearchDisplayController.searchResultsDataSource = self;
    
    
    //注册下拉刷新功能
    __weak CYSurroundingLifeController *weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf insertRowAtTop];
    }];
    //注册上拉刷新功能
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertRowAtBottom];
    }];
    
    
    //获取当前应用程序的委托（UIApplication sharedApplication为整个应用程序上下文）
    self.myDelegate = (HXTAppDelegate *)[[UIApplication sharedApplication] delegate];

    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
    {
        return _searchDataArr.count;

    }
    else
    {
        return _dataArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
    {
        static NSString *CellIdentifier = @"searchCell";
        searchCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[searchCell alloc]initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:CellIdentifier];
        }
        cell.nameLabel.text = _searchDataArr[indexPath.row][@"name"];
        [cell.rateView setRate:[_searchDataArr[indexPath.row][@"grade"]floatValue]];
        cell.addressLabel.text = _searchDataArr[indexPath.row][@"address"];
        cell.distanceLabel.text = [NSString stringWithFormat:@"%@m",_searchDataArr[indexPath.row][@"distance"]];
        NSLog(@"搜索cell的 距离为：%@",_searchDataArr[indexPath.row][@"distance"]);
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SurroundingLifeCell" forIndexPath:indexPath];
        //评分
        [(DJQRateView *)[cell viewWithTag:100] setRate:[_dataArr[indexPath.row][@"grade"]floatValue]];
        //名字
        [(UILabel *)[cell viewWithTag:104] setText:_dataArr[indexPath.row][@"name"]];
        //地址
        [(UILabel *)[cell viewWithTag:105] setText:_dataArr[indexPath.row][@"address"]];
        //距离
        NSString *distanceString = [NSString stringWithFormat:@"%@m",_dataArr[indexPath.row][@"distance"]];
        [(UILabel *)[cell viewWithTag:107] setText:distanceString];

        return cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
    {
        NSLog(@"搜索cell");
        [self performSegueWithIdentifier:@"shopSegue" sender:self];
        
    }
    else
    {
        NSLog(@"商店cell");
        [self performSegueWithIdentifier:@"shopSegue" sender:self];
    }
    
    
    //记录是哪个商店被点击。
    [[NSUserDefaults standardUserDefaults]setValue:_dataArr[indexPath.row][@"id"] forKey:kShopID];
    
}

#pragma mark btn setting
- (IBAction)styleBtnClick:(id)sender
{
    UIButton *button = (UIButton *)sender;
	PCStackMenu *stackMenu = [[PCStackMenu alloc] initWithTitles:[NSArray arrayWithObjects:@"全部商家", @"周边商店", @"周边餐饮", @"周边服务", nil]
													  withImages:[NSArray arrayWithObjects:[UIImage imageNamed:@"life_all_merchant.png"], [UIImage imageNamed:@"life_store@2x.png"], [UIImage imageNamed:@"want_food@2x.png"],[UIImage imageNamed:@"life_service@2x.png"], nil]
													atStartPoint:CGPointMake(button.frame.origin.x + button.frame.size.width, button.frame.origin.y + button.frame.size.height)
														  inView:self.view
													  itemHeight:40
												   menuDirection:PCStackMenuDirectionCounterClockWiseDown];
    
	for(PCStackMenuItem *item in stackMenu.items)
    {
        item.stackTitleLabel.textColor = [UIColor whiteColor];
        item.stackTitleLabel.shadowOffset = CGSizeMake(0, 0);
//        item.stackTitleLabel.backgroundColor = [UIColor orangeColor];
//        item.highlight = YES;
		item.layer.cornerRadius = 10;
		item.layer.masksToBounds = YES;
		item.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.7];

    }
	
	[stackMenu show:^(NSInteger selectedMenuIndex)
    {
        PCStackMenuItem *item = stackMenu.items[selectedMenuIndex];
        [_styleBtn setTitle:[NSString stringWithFormat:@"%@▼",item.stackTitleLabel.text]
                   forState:UIControlStateNormal];
//		NSLog(@"menu index : %d", selectedMenuIndex);
        
        [self.tableView reloadData];
	}];

}
- (IBAction)zhekouBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    [self.tableView reloadData];

}
- (IBAction)songhuoBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    [self.tableView reloadData];

}

#pragma mark searchDisplayControllerDelegate
- (IBAction)seachBtnClick:(id)sender
{
    _cySearchBar.hidden = NO;
    [self.searchDisplayController setActive:YES animated:YES];
}
- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
//    NSLog(@"searchDisplayControllerWillEndSearch");
    _cySearchBar.hidden = YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    _cySearchBar.hidden = YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
//    [_searchDataArr removeAllObjects];
//    for(NSString *str in _searchDataArr)
//    {
//        if([str hasPrefix:searchBar.text])
//        {
//            [_searchDataArr addObject:str];
//        }
//    }
//    [self.tableView reloadData];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(0 == searchText.length)
    {
        return ;
    }
    _searchDataArr = [[NSMutableArray alloc]initWithArray:_dataArr];
    NSMutableArray *tempArr = [[NSMutableArray alloc]initWithArray:_searchDataArr];
    [_searchDataArr removeAllObjects];
    //只能用普通的循环。。才能对其数组本身进行操作。
    for (int i = 0; i < tempArr.count; i++)
    {
//        NSLog(@"dic  name == %@",tempArr[i][@"name"]);
        NSRange range = [tempArr[i][@"name"] rangeOfString:searchText];//判断字符串是否包含
//        NSLog(@"range.length == %d",range.length);
//        NSLog(@"range.location == %d",range.location);
//        NSLog(@"NSNotFound == %d",NSNotFound);
        if (range.location ==NSNotFound)
        {
            //不包含
        }
        else
        {
            //包含
            [_searchDataArr addObject:tempArr[i]];
        }
//        NSLog(@"tempArr.count == %d",tempArr.count);
//        NSLog(@"_searchDataArr == %@",_searchDataArr);
    }
    [self.tableView reloadData];
}
#pragma mark --SVPullToRefresh--
//下拉刷新
- (void)insertRowAtTop
{
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
//         NSMutableDictionary *dic = _dataArr[0];
         NSLog(@"self.dataDic: %@", _dataArr);

         _searchDataArr = [responseObject valueForKey:@"results"];
         //         _searchDataArr = [[NSMutableArray alloc]initWithArray:_dataArr];
         [self.tableView reloadData];
         //存入数据库
         [self saveData];
         [self queryFromDB];
         //停止刷新
         [self.tableView.pullToRefreshView stopAnimating];

     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}
//上拉加载更多
- (void)insertRowAtBottom
{
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
         _searchDataArr = [responseObject valueForKey:@"results"];
         //         _searchDataArr = [[NSMutableArray alloc]initWithArray:_dataArr];
         [self.tableView reloadData];
//         NSLog(@"self.dataDic: %@", _dataArr);
         //停止刷新
         [self.tableView.infiniteScrollingView stopAnimating];
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
}
- (void)saveData
{
    //在写入数据之前先清空表的内容
    [self deleteAllObjects:@"Shop"];
    for (NSMutableDictionary *dic in _dataArr)
    {
        //让CoreData在上下文中创建一个新对象(托管对象)
        Shop *shop = (Shop *)[NSEntityDescription insertNewObjectForEntityForName:@"Shop" inManagedObjectContext:self.myDelegate.managedObjectContext];
        [shop setShopID:[NSString stringWithFormat:@"%@",dic[@"id"]]];

        NSLog(@"save -----> %@",dic[@"name"]);
        [shop setName:dic[@"name"]];
        
        [shop setAddress:dic[@"address"]];
        //自定义了一个图片地址
        [shop setIconPath:@"http://imgt1.bdstatic.com/it/u=2952884929,346785930&fm=21&gp=0.jpg"];
        [shop setType:[NSString stringWithFormat:@"%@",dic[@"type"]]];
        [shop setCansend:dic[@"canSend"]];
        [shop setCanpayoff:dic[@"canPayoff"]];
        [shop setCantuan:dic[@"canTuan"]];
        [shop setPositionX:dic[@"positionX"]];
        [shop setPositionY:dic[@"positionY"]];
        [shop setGrade:dic[@"grade"]];
        [shop setTel:dic[@"tel"]];
        [shop setDistance:[NSString stringWithFormat:@"%@",dic[@"distance"]]];
        
        NSError *error;
        
        //托管对象准备好后，调用托管对象上下文的save方法将数据写入数据库
        BOOL isSaveSuccess = [self.myDelegate.managedObjectContext save:&error];
        
        if (!isSaveSuccess) {
            NSLog(@"Error: %@,%@",error,[error userInfo]);
        }else {
//            NSLog(@"Save successful!");
        }
    }
}
- (void)queryFromDB
{
    //创建取回数据请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //设置要检索哪种类型的实体对象
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Shop"inManagedObjectContext:self.myDelegate.managedObjectContext];
    //设置请求实体
    [request setEntity:entity];
    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(title = %@)",@"123"];
//    [request setPredicate:predicate];
    
    //指定对结果的排序方式
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"ascending:YES];
    //排序条件 数组，可以多个条件排序
    NSArray *sortDescriptions = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];
    
    NSError *error = nil;
    //执行获取数据请求，返回数组
    NSMutableArray *mutableFetchResult = [[self.myDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult == nil)
    {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }
    self.entries = mutableFetchResult;
    NSLog(@"The count of entry:%lu",(unsigned long)[self.entries count]);
    for(Shop *entry in self.entries)
    {
        NSLog(@"Shop ------>  name:%@",entry.name);
    }

}
//删除操作
- (void) deleteAllObjects: (NSString *)entityDescription
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:self.myDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [self.myDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    
    for (NSManagedObject *managedObject in items)
    {
    	[self.myDelegate.managedObjectContext deleteObject:managedObject];
//    	NSLog(@"%@ object deleted",entityDescription);
    }
    if (![self.myDelegate.managedObjectContext save:&error]) {
//    	NSLog(@"Error deleting %@ - error:%@",entityDescription,error);
    }
}

@end
