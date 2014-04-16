//
//  HXTPropertyServiceViewController.h
//  ButlerCard
//
//  Created by niko on 14-4-11.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJQRateView.h"
@interface HXTPropertyServiceViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIButton *houseNameBtn;
@property (strong, nonatomic) NSString *houseName;
@property (weak, nonatomic) IBOutlet DJQRateView *renteRateView;
@property (weak, nonatomic) IBOutlet DJQRateView *repareRateView;

@end
