//
//  CYMyOrderViewController.h
//  ButlerCard
//
//  Created by niko on 14-3-25.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYMyOrderViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)segmentValueChange:(UISegmentedControl *)sender;

@end
