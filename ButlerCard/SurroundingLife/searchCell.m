//
//  searchCell.m
//  ButlerCard
//
//  Created by niko on 14-4-23.
//  Copyright (c) 2014年 johnny. All rights reserved.
//

#import "searchCell.h"

@implementation searchCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //图片
        self.backgroundColor = [UIColor whiteColor];
        _titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 90, 70)];
        _titleImageView.image = [UIImage imageNamed:@"chaoshi.png"];
        [self addSubview:_titleImageView];
        //名称
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(118, 10, 120, 21)];
        _nameLabel.text = @"对面那个小卖部";
        [self addSubview:_nameLabel];
        //评分
        _rateView = [[DJQRateView alloc]initWithFrame:CGRectMake(118, 32, 63, 10)];
        _rateView.userInteractionEnabled = NO;
        [_rateView setRate:3.5];
        [self addSubview:_rateView];
        //送货图标
        _songImg = [[UIImageView alloc]initWithFrame:CGRectMake(118, 47, 12, 12)];
        _songImg.image = [UIImage imageNamed:@"want_song"];
        [self addSubview:_songImg];
        //折扣图标
        _zhekouImg = [[UIImageView alloc]initWithFrame:CGRectMake(138, 47, 12, 12)];
        _zhekouImg.image = [UIImage imageNamed:@"want_zhe"];
        [self addSubview:_zhekouImg];
        //团购图标
        _tuanImg = [[UIImageView alloc]initWithFrame:CGRectMake(158, 47, 12, 12)];
        _tuanImg.image = [UIImage imageNamed:@"want_tuan"];
        [self addSubview:_tuanImg];
        //送地址
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(118, 59, 121, 21)];
        _addressLabel.text = @"出门左拐斜对面";
        _addressLabel.font = [UIFont systemFontOfSize:14];
        _addressLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_addressLabel];
        //收藏按钮
        _loveBtn = [[UIButton alloc]initWithFrame:CGRectMake(282, 10, 18, 22)];
        [_loveBtn setImage:[UIImage imageNamed:@"want_love02"] forState:UIControlStateNormal];
        [self addSubview:_loveBtn];
        //距离
        _distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(226, 57, 74, 21)];
        _distanceLabel.text = @"100m";
        _distanceLabel.font = [UIFont systemFontOfSize:17];
        _distanceLabel.textAlignment = NSTextAlignmentRight;
        _distanceLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_distanceLabel];


        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
