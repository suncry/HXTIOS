//
//  CYSurroundingLifeController.m
//  ButlerCard
//
//  Created by niko on 14-4-22.
//  Copyright (c) 2014年 johnny. All rights reserved.
//

#import "CYSurroundingLifeController.h"
#import "PCStackMenu.h"
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:CellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    /* Configure the cell. */
    
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
        
        cell.textLabel.text = @"searchResultsTableView";
        
    }else{
        
        cell.textLabel.text = @"1111111111111111111";
        
    }   
    
    return cell;
    
    
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
//    _cySearchBar.hidden = YES;
}
@end
