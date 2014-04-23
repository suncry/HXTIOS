//
//  searchCell.h
//  ButlerCard
//
//  Created by niko on 14-4-23.
//  Copyright (c) 2014年 johnny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJQRateView.h"
@interface searchCell : UITableViewCell

@property (retain, nonatomic)  UIImageView *titleImageView;
@property (retain, nonatomic)  UILabel *nameLabel;
@property (retain, nonatomic)  DJQRateView *rateView;
@property (retain, nonatomic)  UIImageView *songImg;
@property (retain, nonatomic)  UIImageView *zhekouImg;
@property (retain, nonatomic)  UIImageView *tuanImg;
@property (retain, nonatomic)  UILabel *addressLabel;
@property (retain, nonatomic)  UIButton *loveBtn;
@property (retain, nonatomic)  UILabel *distanceLabel;

@end
