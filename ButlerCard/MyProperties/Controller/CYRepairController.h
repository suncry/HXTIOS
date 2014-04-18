//
//  CYRepairController.h
//  ButlerCard
//
//  Created by niko on 14-4-16.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface CYRepairController : UITableViewController<UIAlertViewDelegate,MBProgressHUDDelegate>
{
	MBProgressHUD *HUD;
}
- (IBAction)takeCall:(id)sender;

@end
