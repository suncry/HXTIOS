//
//  CYShopController.h
//  ButlerCard
//
//  Created by niko on 14-4-24.
//  Copyright (c) 2014年 johnny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJQRateView.h"
#import "HXTAppDelegate.h"

@interface CYShopController : UITableViewController
//用于CoreData
@property (strong,nonatomic) HXTAppDelegate *myDelegate;

@property (weak, nonatomic) IBOutlet DJQRateView *rateView;
@property (weak, nonatomic) IBOutlet UIButton *telBtn;
@property (retain, nonatomic) NSMutableArray *dataArr;

- (IBAction)takeCall:(id)sender;

@end
