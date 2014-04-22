//
//  HXTHomeChooseHouseEstateTableViewController.m
//  ButlerCard
//
//  Created by johnny tang on 4/14/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTHomeChooseHouseEstateTableViewController.h"

@interface HXTHomeChooseHouseEstateTableViewController ()

@end

@implementation HXTHomeChooseHouseEstateTableViewController

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger numberOfRows;
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            numberOfRows = 1;
            break;
        case 1:
            numberOfRows = 1;
            break;
        case 2:
            numberOfRows = 3;
            break;
        case 3:
            numberOfRows = 6;
            break;
        default:
            numberOfRows = 0;
            break;
    }
    
    return numberOfRows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title;
    switch (section) {
        case 0:
            title = @" ";
            break;
        case 1:
            title = @"当前位置";
            break;
        case 2:
            title = @"我的小区";
            break;
        case 3:
            title = @"全部小区";
            break;
        default:
            title = @" ";
            break;
    }
    
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *allHouseEstateCellIdentifier      = @"AllHouseEstateCellIdentifier";
    static NSString *currentLocationCellIdentifier     = @"CurrentLocationCellIdentifier";
    static NSString *myHouseEstateCellIdentifier       = @"MyHouseEstateCellIdentifier";
    static NSString *theOtherHouseEstateCellIdentifier = @"TheOtherHouseEstateCellIdentifier";
    
    switch (indexPath.section) {
        case 0: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:allHouseEstateCellIdentifier forIndexPath:indexPath];
            return cell;
            break;
        }
        case 1: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:currentLocationCellIdentifier forIndexPath:indexPath];
            return cell;
            break;
        }
        case 2: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myHouseEstateCellIdentifier forIndexPath:indexPath];
            return cell;
            break;
        }
        case 3: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:theOtherHouseEstateCellIdentifier forIndexPath:indexPath];
            return cell;
            break;
        }
            
        default: {
            NSLog(@"%s %s %d Wrong section: %lu", __FILE__, __FUNCTION__, __LINE__, (long)indexPath.section);
            return nil;
            break;
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

#pragma mark - table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section > 0) {
        return 22.0f;
    } else {
        return 0.0f;
    }
}

#pragma mark - IB Actions

- (IBAction)reloadButtonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSLog(@"#####");
}

#pragma mark - Navigation
/*
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}
@end
