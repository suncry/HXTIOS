//
//  CYRentController.h
//  ButlerCard
//
//  Created by niko on 14-4-15.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface CYRentController : UITableViewController<UIAlertViewDelegate,MBProgressHUDDelegate>
{
	MBProgressHUD *HUD;
}
@end