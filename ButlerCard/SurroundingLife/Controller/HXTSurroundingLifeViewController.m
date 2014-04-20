//
//  HXTSurroundingLifeViewController.m
//  ButlerCard
//
//  Created by johnny tang on 2/20/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTSurroundingLifeViewController.h"
#import "HXTAccountManager.h"
#import "HXTViewWithArrow.h"
#import "NSString+FontAwesome.h"
#import "HMSegmentedControl.h"

#define kDurationTime 0.3f

typedef NS_ENUM(NSUInteger, FunctionsGroup) {
    
    FunctionsGroupIsDoorService = 0,
    FunctionsGroupIsBookedConsumption,
    FunctionsGroupIsHouseEstateInteraction,
    FunctionsGroupIsSecondHandGoods,
    FunctionsGroupIsNone = -1
};

@interface HXTSurroundingLifeViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UIView *doorServiceAndBookedConsumptionView;
@property (weak, nonatomic) IBOutlet UIView *houseEstateInteractionAndsecondHandGoodsView;
@property (weak, nonatomic) IBOutlet UIView *extraFunctionsView;
@property (weak, nonatomic) IBOutlet HXTViewWithArrow *subFunctionsArrowView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (assign, nonatomic) FunctionsGroup currentFunctionsGroup;
@property (strong, nonatomic) NSArray *FunctionsGroupItems;

@property (weak, nonatomic) IBOutlet UIButton *chooseHouseEstateButton;
@end

@implementation HXTSurroundingLifeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = NO;
    
    _FunctionsGroupItems = @[@[@"杂货铺", @"外卖", @"维修",
                               @"家政", @"送水", @"开锁",
                               @"缝补", @"洗衣", @"鞋子",
                               @"快递", @"废品回收"],
                             @[@"餐饮", @"美容美发", @"宠物"],
                             @[@"拼车", @"拼饭", @"拼住",
                               @"三缺一", @"出游", @"其他"],
                             @[@"手机", @"小家电", @"家居",
                               @"书籍", @"电器", @"饰品",
                               @"二手车", @"其他"]];
    
    
    _currentFunctionsGroup = FunctionsGroupIsNone;
//    [[HXTAccountManager sharedInstance] addObserver:self
//                                         forKeyPath:@"defaultHouseingEstate"
//                                            options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
//                                            context:NULL];
    
}

//#pragma -- key value abserver
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//    if ([keyPath isEqualToString:@"defaultHouseingEstate"] && object == [HXTAccountManager sharedInstance]) {
//        if ([HXTAccountManager sharedInstance].defaultHouseingEstate) {
//            [_chooseHouseEstateButton setTitle:[HXTAccountManager sharedInstance].defaultHouseingEstate forState:UIControlStateNormal];
//        } else {
//            [_chooseHouseEstateButton setTitle:@"选择小区" forState:UIControlStateNormal];
//        }
//    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _subFunctionsArrowView.hidden = YES;
    
    if ([HXTAccountManager sharedInstance].defaultHouseingEstate) {
        [_chooseHouseEstateButton setTitle:[HXTAccountManager sharedInstance].defaultHouseingEstate forState:UIControlStateNormal];
    } else {
        [_chooseHouseEstateButton setTitle:@"选择小区" forState:UIControlStateNormal];
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 280, 40)];
	label.font = [UIFont fontWithName:kFontAwesomeFamilyName size:33];
    
//	label.text = [NSString fontAwesomeIconStringForIconIdentifier:@"icon-caret-down"];
    label.text = [@"AAA" stringByAppendingString:[NSString fontAwesomeIconStringForIconIdentifier:@"icon-angle-left"]];
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    [self.view bringSubviewToFront:label];
    
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Library", @"Trending", @"News"]];
    [segmentedControl setFrame:CGRectMake(10, 10, 300, 60)];
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [segmentedControl setTag:1];
    [self.view addSubview:segmentedControl];
}

#pragma UICollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_currentFunctionsGroup != FunctionsGroupIsNone) {
        return [_FunctionsGroupItems[_currentFunctionsGroup] count];
    } else {
        return 0;
    }
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *collectionViewCellIdentifier= @"CollectionViewCellIdentifier";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];
    
    UILabel  *cellLabel  = (UILabel *)[cell viewWithTag:100];
    cellLabel.text = _FunctionsGroupItems[_currentFunctionsGroup][indexPath.row];
    
    return cell;
}

#pragma -- UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectItemAtIndexPath indexPath.section = %li, indexPath.row = %li", (long)indexPath.section, (long)indexPath.row);
    switch (_currentFunctionsGroup) {
        case FunctionsGroupIsDoorService: {
            UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TheGroceryStoreStoryboardID"];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        default:
            break;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
	NSLog(@"Selected index %lu (via UIControlEventValueChanged)", (long)segmentedControl.selectedIndex);
}

#pragma mark - IB Actions

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



//上门服务
- (IBAction)doorServiceButtonPressed:(UIButton *)sender {
    _subFunctionsArrowView.hidden = NO;
    if (_currentFunctionsGroup != FunctionsGroupIsDoorService) {
        _subFunctionsArrowView.relativeOrigin = [sender convertPoint:CGPointMake(CGRectGetMidX(sender.frame), CGRectGetMaxY(sender.frame)) toView:self.view];
        NSUInteger subFunctionsArrowViewHeight = [self caculateSubFunctionsArrowViewHeightThroughFunctionsGroup:FunctionsGroupIsDoorService];
        if (_currentFunctionsGroup == FunctionsGroupIsBookedConsumption) {
            
            [UIView animateWithDuration:kDurationTime
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 [_collectionView reloadData];
                                 
                                 _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                           CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame) ,
                                                                           CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                           subFunctionsArrowViewHeight);
                                 
                                 _houseEstateInteractionAndsecondHandGoodsView.frame = CGRectMake(CGRectGetMinX(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                                  CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame) + subFunctionsArrowViewHeight,
                                                                                                  CGRectGetWidth(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                                  CGRectGetHeight(_houseEstateInteractionAndsecondHandGoodsView.frame));
                                 _extraFunctionsView.frame = CGRectMake(CGRectGetMinX(_extraFunctionsView.frame),
                                                                        CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                        CGRectGetWidth(_extraFunctionsView.frame),
                                                                        CGRectGetHeight(_extraFunctionsView.frame));
                                 
                                 [_subFunctionsArrowView horizonMoveArrowFromX:_subFunctionsArrowView.lastRelativeOrigin.x toX:_subFunctionsArrowView.relativeOrigin.x];
                                 
                             }completion:^(BOOL finished){
                             }];

        } else {
            
            [UIView animateWithDuration:kDurationTime
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 [_collectionView reloadData];
                                 _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                           CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame) ,
                                                                           CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                           12.0f);
                                 
                                 _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                           CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame) ,
                                                                           CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                           subFunctionsArrowViewHeight);
                                 _houseEstateInteractionAndsecondHandGoodsView.frame = CGRectMake(CGRectGetMinX(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                                  CGRectGetMaxY(_subFunctionsArrowView.frame),
                                                                                                  CGRectGetWidth(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                                  CGRectGetHeight(_houseEstateInteractionAndsecondHandGoodsView.frame));
                                 _extraFunctionsView.frame = CGRectMake(CGRectGetMinX(_extraFunctionsView.frame),
                                                                        CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                        CGRectGetWidth(_extraFunctionsView.frame),
                                                                        CGRectGetHeight(_extraFunctionsView.frame));
                             }completion:^(BOOL finished){
                             }];
        }
        
         _currentFunctionsGroup = FunctionsGroupIsDoorService;
        
    } else {
        [self hideSubFunctinosInGroup:FunctionsGroupIsDoorService];
        _currentFunctionsGroup = FunctionsGroupIsNone;
    }
}

//预定消费
- (IBAction)bookedConsumptionPressed:(UIButton *)sender {
    _subFunctionsArrowView.hidden = NO;
    
    if (_currentFunctionsGroup != FunctionsGroupIsBookedConsumption) {
        _subFunctionsArrowView.relativeOrigin = [sender convertPoint:CGPointMake(CGRectGetMidX(sender.frame), CGRectGetMaxY(sender.frame)) toView:self.view];
        NSUInteger subFunctionsArrowViewHeight = [self caculateSubFunctionsArrowViewHeightThroughFunctionsGroup:FunctionsGroupIsBookedConsumption];
        if (_currentFunctionsGroup == FunctionsGroupIsDoorService) {
            [UIView animateWithDuration:kDurationTime
                                  delay:0.0f
                                options:UIViewAnimationOptionTransitionNone
                             animations:^{
                                 [_collectionView reloadData];
                                 
                                 _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                           CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame) ,
                                                                           CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                           subFunctionsArrowViewHeight);
                                 _houseEstateInteractionAndsecondHandGoodsView.frame = CGRectMake(CGRectGetMinX(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                                  CGRectGetMaxY(_subFunctionsArrowView.frame),
                                                                                                  CGRectGetWidth(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                                  CGRectGetHeight(_houseEstateInteractionAndsecondHandGoodsView.frame));
                                 _extraFunctionsView.frame = CGRectMake(CGRectGetMinX(_extraFunctionsView.frame),
                                                                        CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                        CGRectGetWidth(_extraFunctionsView.frame),
                                                                        CGRectGetHeight(_extraFunctionsView.frame));
                                 
                                 [_subFunctionsArrowView horizonMoveArrowFromX:_subFunctionsArrowView.lastRelativeOrigin.x toX:_subFunctionsArrowView.relativeOrigin.x];
                                 
                             }completion:^(BOOL finished){ }];
        } else {
            [UIView animateWithDuration:kDurationTime
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 [_subFunctionsArrowView setNeedsDisplay];
                                 [_collectionView reloadData];
                                 _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                           CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame) ,
                                                                           CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                           12.0f);
                                 
                                 _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                           CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame) ,
                                                                           CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                           subFunctionsArrowViewHeight);
                                 _houseEstateInteractionAndsecondHandGoodsView.frame = CGRectMake(CGRectGetMinX(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                                  CGRectGetMaxY(_subFunctionsArrowView.frame),
                                                                                                  CGRectGetWidth(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                                  CGRectGetHeight(_houseEstateInteractionAndsecondHandGoodsView.frame));
                                 _extraFunctionsView.frame = CGRectMake(CGRectGetMinX(_extraFunctionsView.frame),
                                                                        CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                        CGRectGetWidth(_extraFunctionsView.frame),
                                                                        CGRectGetHeight(_extraFunctionsView.frame));
                             }completion:^(BOOL finished){ }];
        }
        _currentFunctionsGroup = FunctionsGroupIsBookedConsumption;
    }else {
        [self hideSubFunctinosInGroup:FunctionsGroupIsBookedConsumption];
        _currentFunctionsGroup = FunctionsGroupIsNone;
    }
}

//小区互动
- (IBAction)houseEstateInteractionButtonPressed:(UIButton *)sender {
    _subFunctionsArrowView.hidden = NO;
    
    if (_currentFunctionsGroup != FunctionsGroupIsHouseEstateInteraction) {
        _subFunctionsArrowView.relativeOrigin = [sender convertPoint:CGPointMake(CGRectGetMidX(sender.frame), CGRectGetMaxY(sender.frame)) toView:self.view];
        NSUInteger subFunctionsArrowViewHeight = [self caculateSubFunctionsArrowViewHeightThroughFunctionsGroup:FunctionsGroupIsHouseEstateInteraction];
        if (_currentFunctionsGroup == FunctionsGroupIsSecondHandGoods) {
            [UIView animateWithDuration:kDurationTime
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 [_collectionView reloadData];
                                 
                                 _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                           CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame) ,
                                                                           CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                           subFunctionsArrowViewHeight);
                                 _extraFunctionsView.frame = CGRectMake(CGRectGetMinX(_extraFunctionsView.frame),
                                                                        CGRectGetMaxY(_subFunctionsArrowView.frame),
                                                                        CGRectGetWidth(_extraFunctionsView.frame),
                                                                        CGRectGetHeight(_extraFunctionsView.frame));
                                 [_subFunctionsArrowView horizonMoveArrowFromX:_subFunctionsArrowView.lastRelativeOrigin.x toX:_subFunctionsArrowView.relativeOrigin.x];
                             } completion:^(BOOL finished){ }];
        } else {
            [UIView animateWithDuration:kDurationTime
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 [_collectionView reloadData];
                                 [_subFunctionsArrowView setNeedsDisplay];
                                 _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                           CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame) ,
                                                                           CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                           0.0f);
                                 
                                 _houseEstateInteractionAndsecondHandGoodsView.frame = CGRectMake(CGRectGetMinX(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                                  CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame),
                                                                                                  CGRectGetWidth(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                                  CGRectGetHeight(_houseEstateInteractionAndsecondHandGoodsView.frame));
                                 
                                 _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                           CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame) ,
                                                                           CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                           subFunctionsArrowViewHeight);
                                 _extraFunctionsView.frame = CGRectMake(CGRectGetMinX(_extraFunctionsView.frame),
                                                                        CGRectGetMaxY(_subFunctionsArrowView.frame),
                                                                        CGRectGetWidth(_extraFunctionsView.frame),
                                                                        CGRectGetHeight(_extraFunctionsView.frame));
                             } completion:^(BOOL finished){ }];
        }
        _currentFunctionsGroup = FunctionsGroupIsHouseEstateInteraction;
    }else {
        [self hideSubFunctinosInGroup:FunctionsGroupIsHouseEstateInteraction];
        _currentFunctionsGroup = FunctionsGroupIsNone;
    }
}

//二手物品
- (IBAction)secondHandGoodsButtonPressed:(UIButton *)sender {
    _subFunctionsArrowView.hidden = NO;
    if (_currentFunctionsGroup != FunctionsGroupIsSecondHandGoods) {
        _subFunctionsArrowView.relativeOrigin = [sender convertPoint:CGPointMake(CGRectGetMidX(sender.frame), CGRectGetMaxY(sender.frame)) toView:self.view];
        NSUInteger subFunctionsArrowViewHeight = [self caculateSubFunctionsArrowViewHeightThroughFunctionsGroup:FunctionsGroupIsSecondHandGoods];
        if (_currentFunctionsGroup == FunctionsGroupIsHouseEstateInteraction) {
            [UIView animateWithDuration:kDurationTime
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 [_collectionView reloadData];
                                 
                                 _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                           CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame) ,
                                                                           CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                           subFunctionsArrowViewHeight);
                                 _extraFunctionsView.frame = CGRectMake(CGRectGetMinX(_extraFunctionsView.frame),
                                                                        CGRectGetMaxY(_subFunctionsArrowView.frame),
                                                                        CGRectGetWidth(_extraFunctionsView.frame),
                                                                        CGRectGetHeight(_extraFunctionsView.frame));
                                 [_subFunctionsArrowView horizonMoveArrowFromX:_subFunctionsArrowView.lastRelativeOrigin.x toX:_subFunctionsArrowView.relativeOrigin.x];
                             } completion:^(BOOL finished){
                             }];
        } else {
            [UIView animateWithDuration:kDurationTime
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 [_collectionView reloadData];
                                 [_subFunctionsArrowView setNeedsDisplay];
                                 _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                           CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame) ,
                                                                           CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                           0.0f);
                                 
                                 _houseEstateInteractionAndsecondHandGoodsView.frame = CGRectMake(CGRectGetMinX(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                                  CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame),
                                                                                                  CGRectGetWidth(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                                  CGRectGetHeight(_houseEstateInteractionAndsecondHandGoodsView.frame));
                                 
                                 _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                           CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame) ,
                                                                           CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                          subFunctionsArrowViewHeight);
                                 _extraFunctionsView.frame = CGRectMake(CGRectGetMinX(_extraFunctionsView.frame),
                                                                        CGRectGetMaxY(_subFunctionsArrowView.frame),
                                                                        CGRectGetWidth(_extraFunctionsView.frame),
                                                                        CGRectGetHeight(_extraFunctionsView.frame));
                             } completion:^(BOOL finished){ }];
        }
        _currentFunctionsGroup = FunctionsGroupIsSecondHandGoods;
    }else {
        [self hideSubFunctinosInGroup:FunctionsGroupIsSecondHandGoods];
        _currentFunctionsGroup = FunctionsGroupIsNone;
    }
}

//手机充值
- (IBAction)rechargeButtonPressed:(id)sender {
    NSLog(@"手机充值");
}

//推荐信息
- (IBAction)recommendInfomationButtonPressed:(id)sender {
    NSLog(@"推荐信息");
}

- (IBAction)backgroundTouchUpInside:(id)sender {
    NSLog(@"backgroundTouchUpInside");
    [self hideSubFunctinosInGroup:_currentFunctionsGroup];
}

#pragma mark -- scroview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!CGSizeEqualToSize(_scrollView.contentSize, _coverView.frame.size)) {
        _scrollView.contentSize = _coverView.frame.size;
    }
}


#pragma mark -- local functions


- (NSUInteger)caculateSubFunctionsArrowViewHeightThroughFunctionsGroup:(FunctionsGroup)group {
    
    if (group != FunctionsGroupIsNone) {
        NSUInteger numberOfItems = [_FunctionsGroupItems[group] count];
        
        float rowTemp = numberOfItems / 3.0;
        NSUInteger row = (fabs(rowTemp - (NSUInteger)rowTemp) < 0.01) ? rowTemp : (NSUInteger)rowTemp + 1;
        
        return row * 40 + 12;;
    } else {
        return 0;
    }
}

- (void)showSubFunctionInGroup:(FunctionsGroup)group {
     _subFunctionsArrowView.hidden = NO;
//     NSUInteger subFunctionsArrowViewHeight = [self caculateSubFunctionsArrowViewHeightThroughFunctionsGroup:group];
    
    if (group == FunctionsGroupIsDoorService) { //上门服务
        
    } else if (group == FunctionsGroupIsBookedConsumption) { //预定消费
        
    } else if (group == FunctionsGroupIsHouseEstateInteraction) { //小区互动
        
    } else if (group == FunctionsGroupIsSecondHandGoods) { //二手物品
        
    } else { //functionsGroup == FunctionsGroupIsNone 不显式子功能 
        
    }
}

- (void)hideSubFunctinosInGroup:(FunctionsGroup)group {
    if (group == FunctionsGroupIsDoorService || group == FunctionsGroupIsBookedConsumption) { //上门服务 预定消费
        [UIView animateWithDuration:kDurationTime
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                       CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame) ,
                                                                       CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                       0);
                             _houseEstateInteractionAndsecondHandGoodsView.frame = CGRectMake(CGRectGetMinX(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                              CGRectGetMaxY(_subFunctionsArrowView.frame),
                                                                                              CGRectGetWidth(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                              CGRectGetHeight(_houseEstateInteractionAndsecondHandGoodsView.frame));
                             _extraFunctionsView.frame = CGRectMake(CGRectGetMinX(_extraFunctionsView.frame),
                                                                    CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                    CGRectGetWidth(_extraFunctionsView.frame),
                                                                    CGRectGetHeight(_extraFunctionsView.frame));
                         }completion:^(BOOL finished){
                             _currentFunctionsGroup = FunctionsGroupIsNone;
                         }];
    } else if (group == FunctionsGroupIsHouseEstateInteraction || group == FunctionsGroupIsSecondHandGoods) { //小区互动 二手物品
        [UIView animateWithDuration:kDurationTime
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                       CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame) ,
                                                                       CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                       0);
                             _houseEstateInteractionAndsecondHandGoodsView.frame = CGRectMake(CGRectGetMinX(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                              CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame),
                                                                                              CGRectGetWidth(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                              CGRectGetHeight(_houseEstateInteractionAndsecondHandGoodsView.frame));
                             _extraFunctionsView.frame = CGRectMake(CGRectGetMinX(_extraFunctionsView.frame),
                                                                    CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                    CGRectGetWidth(_extraFunctionsView.frame),
                                                                    CGRectGetHeight(_extraFunctionsView.frame));
                         }completion:^(BOOL finished){
                             _currentFunctionsGroup = FunctionsGroupIsNone;
                         }];
        
    } else { //FunctionsGroupIsNone NOP
        
    }
}

@end
