//
//  HXTViewWithArrow.m
//  ButlerCard
//
//  Created by johnny tang on 3/3/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//


#import "HXTViewWithArrow.h"

#define kArrowHeight 12
#define kArrowWidth  20
@interface HXTViewWithArrow ()
@property(strong, nonatomic) UIImageView *arrowView;
@property(strong, nonatomic) UIImageView *backgroundView;
@property(strong, nonatomic) UIView *contentView;
@end

@implementation HXTViewWithArrow


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //we need to set the background as clear to see the view below
        [self myInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        //we need to set the background as clear to see the view below
        
        [self myInit];
    }
    
    return self;
}

- (void)myInit{
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    for (UIView *aSubView in self.subviews) {
        _contentView = aSubView;
    }
    _relativeOrigin = CGPointZero;
    
    _contentView.frame = CGRectMake(CGRectGetMinX(self.frame), kArrowHeight, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - kArrowHeight);
    
    _backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.frame), kArrowHeight, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - kArrowHeight)];
    _backgroundView.image = [UIImage imageNamed:@"global_viewWithArrow_bg"];
    [self addSubview:_backgroundView];
    
    _arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kArrowWidth, kArrowHeight)];
    _arrowView.image = [UIImage imageNamed:@"global_viewWithArrow_up"];
    [self addSubview:_arrowView];
    
    [self bringSubviewToFront:_contentView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _arrowView.frame = CGRectMake(_relativeOrigin.x - kArrowWidth / 2.0, 0, CGRectGetWidth(_arrowView.frame), CGRectGetHeight(_arrowView.frame));
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    
    /*
    //拿到当前视图准备好的画板
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制图形
    CGContextBeginPath(context);//标记
    CGContextMoveToPoint(context, 0, CGRectGetMaxY(self.bounds));//设置起点
    CGContextAddLineToPoint(context, 0, kArrowHeight);
    CGContextAddLineToPoint(context, _relativeOrigin.x - kArrowWidth / 2.0, kArrowHeight);
    CGContextAddLineToPoint(context, _relativeOrigin.x, 0);
    CGContextAddLineToPoint(context, _relativeOrigin.x + kArrowWidth / 2.0, kArrowHeight);
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds), kArrowHeight);
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds));
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    [[UIColor colorWithWhite:0.4 alpha:0.9] setFill]; //设置填充色
    [[UIColor blackColor] setStroke]; //设置边框颜色
    CGContextSetAlpha(context, _contentView.alpha);
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path
     */
}

#pragma mark - Setter and Getter Methords

- (void)setRelativeOrigin:(CGPoint)relativeOrigin {
    _lastRelativeOrigin = _relativeOrigin;
    _relativeOrigin = relativeOrigin;
}

- (void)horizonMoveArrowFromX:(float)sourceX toX:(float)destX; {
    
    CAKeyframeAnimation *move = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    move.duration = 0.5f;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, sourceX, kArrowHeight / 2.0);
    CGPathAddLineToPoint(path, NULL, destX, kArrowHeight / 2.0);
    move.path = path;
    
    CGPathRelease(path);
    
    CAAnimationGroup *totalAnimation = [CAAnimationGroup animation];
    totalAnimation.duration = 0.5f;
    totalAnimation.animations = @[move];
    totalAnimation.fillMode = kCAFillModeForwards;
    totalAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    totalAnimation.delegate = self;
    
    _arrowView.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
    [_arrowView.layer addAnimation:totalAnimation forKey:@"arrowMove"];
}

@end
