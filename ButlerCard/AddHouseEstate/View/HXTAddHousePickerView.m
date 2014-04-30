//
//  HXTAddHousePickerView.m
//  ButlerCard
//
//  Created by johnny tang on 4/30/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import "HXTAddHousePickerView.h"

#define kWinSize [UIScreen mainScreen].bounds.size

@interface HXTAddHousePickerView ()

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (strong, nonatomic) UIControl *coverView;
@property (assign, nonatomic) BOOL isShowing;

@end

@implementation HXTAddHousePickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self _setup];
    }
    return self;
}

- (void)_setup {
    
    self.frame = CGRectMake(0, kWinSize.height, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    _coverView = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [_coverView addTarget:self action:@selector(_backgroundTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    _coverView.userInteractionEnabled = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - UIPickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger rows = 0;
    switch (component) {
        case 0:
            rows = 15;
            break;
        case 1:
            rows = 4;
            break;
        case 2:
            rows = 20;
            break;
        default:
            break;
    }
    return rows;
}

#pragma mark - UIPickerView Delegate

/*
 - (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
 
 }
 
 - (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
 
 }
 */

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    switch (component) {
        case 0:
            title = [NSString stringWithFormat:@"%lu栋", (long)(row + 1)];
            break;
        case 1:
            title = [NSString stringWithFormat:@"%lu单元", (long)(row + 1)];
            break;
        case 2:
            title = [NSString stringWithFormat:@"%lu", (long)(100 * (row / 2 + 1) + row + 1)];
            break;
        default:
            break;
    }
    
    return title;
}

/*
 - (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
 
 }
 
 - (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
 
 }
 */

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"row = %lu, component = %lu", (long)row, (long)component);
}

#pragma mark - local functions

- (void)_backgroundTouchUpInside {
    [self hide];
}

#pragma makr - IB Actions

- (IBAction)cancelButtonPressed:(id)sender {
    [self hide];
}


- (IBAction)doneButtonPressed:(id)sender {
    [self hide];
}

#pragma mark - public functions

- (void)show {
    [[UIApplication sharedApplication].windows.lastObject addSubview:_coverView];
    [[UIApplication sharedApplication].windows.lastObject addSubview:self];
    
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionTransitionFlipFromBottom
                     animations:^{
                         self.frame = CGRectMake(0, kWinSize.height - CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
                     }
                     completion:^(BOOL finished){
                         _coverView.userInteractionEnabled = YES;
                         _isShowing = YES;
                     }];
}

- (void)hide {
    [_coverView removeFromSuperview];
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionTransitionFlipFromBottom
                     animations:^{
                         self.frame = CGRectMake(0, kWinSize.height, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         _coverView.userInteractionEnabled = NO;
                         _isShowing = NO;
                     }];
}

@end
