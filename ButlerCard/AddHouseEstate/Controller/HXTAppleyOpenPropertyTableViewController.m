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
@property (strong, nonatomic) MBProgressHUD *HUD;

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
    if (alertView == _errorAlertView) {
        _errorAlertView = nil;
    } else if (alertView == _applyAlertView) {
        switch (buttonIndex) {
            case 0: //Cancel Button pressed
                [_textField becomeFirstResponder];
                break;
            case 1: { //OK Button pressed
                if (!_HUD) {
                    _HUD = [[MBProgressHUD alloc] initWithView:self.view.window];
                    [self.view.window addSubview:_HUD];
                    _HUD.delegate = self;
                }
                [_HUD showWhileExecuting:@selector(_applyOpenProperty) onTarget:self withObject:nil animated:YES];
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

#pragma mark - 

- (void)hudWasHidden:(MBProgressHUD *)hud {
    [hud removeFromSuperview];
    hud = nil;
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


@end
