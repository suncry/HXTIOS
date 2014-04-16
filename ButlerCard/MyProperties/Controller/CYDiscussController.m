//
//  CYDiscussController.m
//  ButlerCard
//
//  Created by niko on 14-4-14.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import "CYDiscussController.h"
#import "AFNetworking.h"
#import "DJQRateView.h"
@interface CYDiscussController ()

@end

@implementation CYDiscussController

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
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"tenement_id": @"1",@"id": @"1",@"size": @"6",@"offset": @"2",@"sid": @"66d804a0bb4c0a06",};
    [manager POST:@"http://bbs.enveesoft.com:1602/htx/hexinpassserver/appserver/public/serv/list" parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        _dataArr = [responseObject valueForKey:@"results"];
        [self.tableView reloadData];
        NSLog(@"self.dataDic: %@", _dataArr);
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"Error: %@", error);
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"discussTitleCell" forIndexPath:indexPath];
        return cell;
        
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"discussCommentCell" forIndexPath:indexPath];
        /**
         *  各个控件的tag 星星100 名字101 内容102 时间103 物业回复104
         */
        NSDictionary *dataDic = [[NSDictionary alloc]init];
        dataDic = _dataArr[indexPath.row - 1];
        [(DJQRateView *)[cell viewWithTag:100] setRate:[dataDic[@"grade"]floatValue]];
        [(UILabel *)[cell viewWithTag:101] setText:dataDic[@"nickname"]];
        [(UILabel *)[cell viewWithTag:102] setText:dataDic[@"comment"]];
        [(UILabel *)[cell viewWithTag:103] setText:dataDic[@"time"]];
        [(UILabel *)[cell viewWithTag:104] setText:[NSString stringWithFormat:@"  物业回复:%@",dataDic[@"replyMessage"]]];
        return cell;
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 60;
    }
    else
    {
        return 80;
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

@end
