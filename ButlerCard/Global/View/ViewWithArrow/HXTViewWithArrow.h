//
//  HXTViewWithArrow.h
//  ButlerCard
//
//  Created by johnny tang on 3/3/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXTViewWithArrow : UIView

@property(assign, nonatomic) CGPoint relativeOrigin;
@property(assign, nonatomic) CGPoint lastRelativeOrigin;

- (void)horizonMoveArrowFromX:(float)sourceX toX:(float)destX;

@end
