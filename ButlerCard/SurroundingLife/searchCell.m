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
