//
//  CYOrderCell.m
//  ButlerCard
//
//  Created by niko on 14-3-26.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import "CYOrderCell.h"

@implementation CYOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
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
