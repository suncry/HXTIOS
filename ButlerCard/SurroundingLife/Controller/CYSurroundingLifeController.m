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
//         _searchDataArr = [responseObject valueForKey:@"results"];
         _searchDataArr = [[NSMutableArray alloc]initWithArray:_dataArr];
         [self.tableView reloadData];
//         NSLog(@"self.dataDic: %@", _dataArr);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
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
//    _cySearchDisplayController.searchResultsTableView.delegate = self;
//    _cySearchDisplayController.searchResultsTableView.dataSource = self;

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
	}];

}
- (IBAction)zhekouBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
}
- (IBAction)songhuoBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
}

#pragma mark searchDisplayControllerDelegate
- (IBAction)seachBtnClick:(id)sender
{
    _cySearchBar.hidden = NO;
    [self.searchDisplayController setActive:YES animated:YES];
}
//- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
//{
//    NSLog(@"searchDisplayControllerWillBeginSearch");
//}
//- (void) searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
//{
//    NSLog(@"searchDisplayControllerDidBeginSearch");
//
//}
- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
//    NSLog(@"searchDisplayControllerWillEndSearch");
    _cySearchBar.hidden = YES;


}
//- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
//{
//    NSLog(@"searchDisplayControllerDidEndSearch");
//
//}

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
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
//{
//    NSLog(@"开始搜索！");
//}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(0 == searchText.length)
    {
        return ;
    }
//    NSLog(@"_searchDataArr == %@",_searchDataArr);
    NSMutableArray *tempArr = _searchDataArr;
//    [_searchDataArr removeAllObjects];
    for(NSDictionary *dic in _searchDataArr)
    {
        if ([dic[@"name"] hasPrefix:searchText])
        {
//            [tempArr addObject:dic];
            NSLog(@"dic  name == %@",dic[@"name"]);

            NSLog(@"有匹配结果！");
        }
    }
//    [_searchDataArr removeAllObjects];
//    _searchDataArr = tempArr;
    [self.tableView reloadData];

}

@end
