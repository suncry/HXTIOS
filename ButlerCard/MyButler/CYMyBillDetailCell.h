//
//  CYMyBillDetailCell.h
//  ButlerCard
//
//  Created by niko on 14-3-20.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYMyBillDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *moneyLable;
@property(nonatomic,retain)UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *stateLable;

@end
