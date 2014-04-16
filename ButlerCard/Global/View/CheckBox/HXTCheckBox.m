//
//  HXTCheckBox.m
//  ButlerCard
//
//  Created by johnny tang on 2/25/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#define kUncheckedImage @"global_point"
#define kCheckedImage   @"global_point_s"
#import "HXTCheckBox.h"

@implementation HXTCheckBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundImage:[UIImage imageNamed:kUncheckedImage] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:kCheckedImage] forState:UIControlStateSelected];
        [self addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:kUncheckedImage] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:kCheckedImage] forState:UIControlStateSelected];
        [self addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)buttonPressed {
    self.selected = !self.selected;
}

@end
