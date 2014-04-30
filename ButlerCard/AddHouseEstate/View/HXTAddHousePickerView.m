//
//  HXTAddHousePickerView.m
//  ButlerCard
//
//  Created by johnny tang on 4/30/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import "HXTAddHousePickerView.h"

#define kBuildingNo             @"buildingNo"
#define kUnitNo                 @"unitNo"
#define kHouseNo                @"houseNo"
#define kWinSize [UIScreen mainScreen].bounds.size

@interface HXTAddHousePickerView ()

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (strong, nonatomic) UIControl *coverView;
@property (assign, nonatomic) BOOL isShowing;
@property (assign, nonatomic) NSString *buidindNo;
@property (assign, nonatomic) NSString *unitNo;
@property (assign, nonatomic) NSString *houseNo;

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

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_houseList.count > 0) {
        _buidindNo = _houseList.allKeys[0]; //获取第一个楼号
        NSLog(@"_buidindNo = %@", _buidindNo);
        if ([_houseList[_buidindNo] allKeys] > 0) {
            _unitNo = [_houseList[_buidindNo] allKeys][0]; //获取第一个单元号
            NSLog(@"_unitNo = %@", _unitNo);
            if ([_houseList[_buidindNo][_unitNo] count] > 0) {
                _houseNo = _houseList[_buidindNo][_unitNo][0]; //获取第一个房间号
                NSLog(@"_houseNo = %@", _houseNo);
            }
        }
    }
    
    [self.pickerView reloadAllComponents];
}

#pragma mark - UIPickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger rows = 0;
    switch (component) {
        case 0:
            rows = _houseList.allKeys.count;
            NSLog(@"0rows = %lu", (long)rows);
            break;
        case 1:
            rows = [[_houseList[_buidindNo] allKeys] count];
            NSLog(@"1rows = %lu", (long)rows);
            break;
        case 2:
            rows = [_houseList[_buidindNo][_unitNo] count];
            NSLog(@"2rows = %lu", (long)rows);
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
            title = [NSString stringWithFormat:@"%@栋", _houseList.allKeys[row]];
            break;
        case 1:
            title = [NSString stringWithFormat:@"%@单元", [_houseList[_buidindNo] allKeys][row]];
            break;
        case 2:
            title = [NSString stringWithFormat:@"%@号", _houseList[_buidindNo][_unitNo][row]];
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
    switch (component) {
        case 0:
            _buidindNo = _houseList.allKeys[row];
            [_pickerView reloadComponent:1];
            [_pickerView selectRow:0 inComponent:1 animated:YES];
            _unitNo = [_houseList[_buidindNo] allKeys][0];
            [_pickerView reloadComponent:2];
            [_pickerView selectRow:0 inComponent:2 animated:YES];
            _houseNo = _houseList[_buidindNo][_unitNo][0];
            break;
        case 1:
            _unitNo = [_houseList[_buidindNo] allKeys][row];
            [_pickerView reloadComponent:2];
            [_pickerView selectRow:0 inComponent:2 animated:YES];
            _houseNo = _houseList[_buidindNo][_unitNo][0];
            break;
        case 2:
            _houseNo = _houseList[_buidindNo][_unitNo][row];
            break;
        default:
            break;
    }
    
    NSLog(@"selected %@栋 %@单元 %@", _buidindNo, _unitNo, _houseNo);
}

#pragma mark - local functions

- (void)_backgroundTouchUpInside {
    [self hide];
}

#pragma makr - IB Actions

- (IBAction)doneBarButtonItemPressed:(UIBarButtonItem *)sender {
    [self hide];
    //    if (_delegate && [_delegate respondsToSelector:@selector(pickerDidPressDoneWithStarDateComponents:andEndComponents:)]) {
    //        [_delegate pickerDidPressDoneWithStarDateComponents:_curStartComps andEndComponents:_curEndComps];
    //    }
}
- (IBAction)cancelBarButtonItemPressed:(UIBarButtonItem *)sender {
    [self hide];
    
    if (_delegate && [_delegate respondsToSelector:@selector(pickerDidPressCancel)]) {
        [_delegate pickerDidPressCancel];
    }
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
