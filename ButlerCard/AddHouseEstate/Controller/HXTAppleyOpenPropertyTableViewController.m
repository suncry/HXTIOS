//
//  HXTAppleyOpenPropertyTableViewController.m
//  ButlerCard
//
//  Created by johnny tang on 5/5/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import "HXTAppleyOpenPropertyTableViewController.h"
#import "MBProgressHUD.h"

@interface HXTAppleyOpenPropertyTableViewController () <UIAlertViewDelegate, MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) UIAlertView *errorAlertView;
@property (strong, nonatomic) UIAlertView *applyAlertView;
@property (strong, nonatomic) UIAlertView *applyResultAlertView;

@end

@implementation HXTAppleyOpenPropertyTableViewController

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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}
 */

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"######indexPath.section = %lu, indexPath.row = %lu", (long)indexPath.section, (long)indexPath.row);
    if (indexPath.section == 1 && indexPath.row == 0) {
        if (_textField.text.length == 0 || _textField.text == nil) {
            _errorAlertView = [[UIAlertView alloc] initWithTitle:@"警告"
                                                                message:@"小区名称不能为空。"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles: nil];
            [_errorAlertView show];
        } else {
            [_textField resignFirstResponder];
            NSString *alerString = [NSString  stringWithFormat:@"你申请开通的小区是%@", _textField.text];
            _applyAlertView = [[UIAlertView alloc] initWithTitle:nil
                                                                message:alerString
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:@"确定",nil];
            [_applyAlertView show];
        }
    }
}

#pragma mark - Alert view deleage

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex = %lu", (long)buttonIndex);
    if (alertView == _errorAlertView) {
        _errorAlertView = nil;
    } else if (alertView == _applyAlertView) {
        switch (buttonIndex) {
            case 0: //Cancel Button pressed
                [_textField becomeFirstResponder];
                break;
            case 1: { //OK Button pressed
                MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view.window];
                [self.view.window addSubview:HUD];
                HUD.delegate = self;
                [HUD showWhileExecuting:@selector(_applyOpenProperty) onTarget:self withObject:nil animated:YES];
            }
                break;
            default:
                break;
        }
    } else if (alertView == _applyResultAlertView) {
        _applyResultAlertView = nil;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Local functions
- (void)_applyOpenProperty {
    sleep(1);
    _applyResultAlertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"我们已记录你的申请，会尽快联系物业开通小区服务。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [_applyResultAlertView show];
}

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
