//
//  HXTPropertyServiceViewController.h
//  ButlerCard
//
//  Created by niko on 14-4-11.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJQRateView.h"
#import "MBProgressHUD.h"

@interface HXTPropertyServiceViewController : UITableViewController<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;

}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *chooseHouseEstateBarButtonItem;
@property (strong, nonatomic) NSString *houseName;
@property (weak, nonatomic) IBOutlet DJQRateView *rentRateView;
@property (weak, nonatomic) IBOutlet DJQRateView *repairRateView;
@property (weak, nonatomic) IBOutlet UIButton *rentCommentBtn;
@property (weak, nonatomic) IBOutlet UIButton *repairCommentBtn;
@property (nonatomic,retain)NSMutableArray *dataArr;

@end
