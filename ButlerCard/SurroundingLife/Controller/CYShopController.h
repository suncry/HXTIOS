//
//  CYShopController.h
//  ButlerCard
//
//  Created by niko on 14-4-24.
//  Copyright (c) 2014年 johnny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJQRateView.h"
@interface CYShopController : UITableViewController
@property (weak, nonatomic) IBOutlet DJQRateView *rateView;
@property (retain, nonatomic) NSMutableArray *dataArr;

- (IBAction)takeCall:(id)sender;

@end
