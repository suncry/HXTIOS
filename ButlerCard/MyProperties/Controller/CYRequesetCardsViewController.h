//
//  CYRequesetCardsViewController.h
//  ButlerCard
//
//  Created by niko on 14-5-5.
//  Copyright (c) 2014年 johnny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface CYRequesetCardsViewController : UIViewController<MBProgressHUDDelegate,UIAlertViewDelegate>
{
    MBProgressHUD *HUD;
}
- (IBAction)sendBtnClick:(id)sender;
- (IBAction)testBtnClick:(id)sender;

@end
