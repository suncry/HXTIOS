//
//  HXTPropertyFeePayViewController.m
//  ButlerCard
//
//  Created by johnny tang on 4/18/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import "HXTPropertyFeePayViewController.h"
#import "HXTYearMonthIntervalPickerView.h"
#import "HXTPropertyFeeInputMoneyTableViewController.h"

@interface HXTPropertyFeePayViewController () <UITextFieldDelegate, HXTYearMonthIntervalPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (strong, nonatomic) NSArray *feeTypeName;
@property (strong, nonatomic) HXTYearMonthIntervalPickerView *yearMonthIntervalPicker;
@property (strong, nonatomic) UIButton *selectedButton;
@end

@implementation HXTPropertyFeePayViewController

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        _segmentedControl.tintColor = [UIColor whiteColor];
    }
    
    _feeTypeName = @[@"物管费", @"停车费", @"水费", @"电费", @"气费"];
    
    _yearMonthIntervalPicker = [[[NSBundle mainBundle] loadNibNamed:@"HXTYearMonthIntervalPickerView" owner:self options:nil] lastObject];
    _yearMonthIntervalPicker.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(inputMoneyNotificationSelector:)
                                                 name:kInputMoneyNotification
                                               object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        _segmentedControl.tintColor = [UIColor whiteColor];
    }
    
    if (_selectedButton) {
        _selectedButton.selected = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - notification abserver

- (void)inputMoneyNotificationSelector:(NSNotification *)notification {
    if ([notification.name isEqualToString:kInputMoneyNotification]) {
        NSLog(@"%@", notification.userInfo);
        if (_selectedButton && _selectedButton.tag == 105) {
            [_selectedButton setTitle:notification.userInfo[@"money"] forState:UIControlStateNormal];
            _selectedButton.selected = NO;
        }
    }
}

#pragma mark - table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TypeOneCellIdentifier = @"TypeOneCellIdentifier";
    static NSString *TypeTwoCellIdentifier = @"TypeTwoCellIdentifier";
    static NSString *TypeThreeCellIdentifier = @"TypeThreeCellIdentifier";
    
    if (_segmentedControl.selectedSegmentIndex == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TypeOneCellIdentifier forIndexPath:indexPath];
        // Configure the cell...
        
        cell.tag = indexPath.row;
        ((UIButton *)[cell viewWithTag:101]).selected = YES;
        ((UILabel *)[cell viewWithTag:102]).text = _feeTypeName[indexPath.row];
        
        return cell;
    } else {
        if (indexPath.row < 2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TypeTwoCellIdentifier forIndexPath:indexPath];
            
            // Configure the cell...
            cell.tag = indexPath.row;
            
            ((UIButton *)[cell viewWithTag:101]).selected = YES;
            ((UILabel *)[cell viewWithTag:102]).text = _feeTypeName[indexPath.row];
        
//            ((UITextField *)[cell viewWithTag:104]).inputView = _yearMonthIntervalPicker;
//            ((UITextField *)[cell viewWithTag:104]).delegate = self;
            
            return cell;
        } else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TypeThreeCellIdentifier forIndexPath:indexPath];
            
            // Configure the cell...
            
            cell.tag = indexPath.row;
            
            ((UIButton *)[cell viewWithTag:101]).selected = YES;
            ((UILabel *)[cell viewWithTag:102]).text = _feeTypeName[indexPath.row];
            
            return cell;
        }
    }
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UIButton *checkBoxImage = (UIButton *)[cell viewWithTag:101];
    checkBoxImage.selected = !checkBoxImage.selected;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - HXTYearMonthIntervalPickerView delegate

- (void)pickerDidSelectStartDateComponents:(NSDateComponents *)startComps andEndComponents:(NSDateComponents *)endComps {
    NSLog(@"startComps = %@, endComps = %@, ", startComps, endComps);
    NSString *date = [NSString stringWithFormat:@"%4lu年%02lu月~%4lu年%02lu月",(long)startComps.year, (long)startComps.month, (long)endComps.year, (long)endComps.month];
    [_selectedButton setTitle:date forState:UIControlStateSelected];
}

- (void)pickerDidPressDoneWithStarDateComponents:(NSDateComponents *)startComps andEndComponents:(NSDateComponents *)endComps {
    NSString *date = [NSString stringWithFormat:@"%4lu年%02lu月~%4lu年%02lu月",(long)startComps.year, (long)startComps.month, (long)endComps.year, (long)endComps.month];
    [_selectedButton setTitle:date forState:UIControlStateNormal];
    _selectedButton.selected = NO;
}

- (void)pickerDidPressCancelWithStarDateComponents:(NSDateComponents *)startComps andEndComponents:(NSDateComponents *)endComps {
    NSString *date = [NSString stringWithFormat:@"%4lu年%02lu月~%4lu年%02lu月",(long)startComps.year, (long)startComps.month, (long)endComps.year, (long)endComps.month];
    [_selectedButton setTitle:date forState:UIControlStateNormal];
    _selectedButton.selected = NO;
}


#pragma mark - IB Actions

- (IBAction)checkBoxButtonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    UIView *view = sender.superview;
    while (view && view.superview) {
        if ([view isKindOfClass:[UITableViewCell class]]) {
            NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)view];
            NSLog(@"indexPath.row = %lu", (long)indexPath.row);
            
            return;
        }
        view = view.superview;
    }
}

- (IBAction)chooseDateButtonPresssed:(UIButton *)sender {
    sender.selected = !sender.selected;
    _selectedButton = sender;
    
    UIView *view = sender.superview;
    while (view && view.superview) {
        if ([view isKindOfClass:[UITableViewCell class]]) {
            NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)view];
            NSLog(@"indexPath.row = %lu", (long)indexPath.row);
            
            NSDateComponents *startComps = [[NSDateComponents alloc] init];
            startComps.year = 2011;
            startComps.month = 1;
            
            NSDateComponents *endComps = [[NSDateComponents alloc] init];
            endComps.year = 2014;
            endComps.month = 12;
            _yearMonthIntervalPicker.startComps = startComps;
            _yearMonthIntervalPicker.endComps = endComps;
            
            [_yearMonthIntervalPicker show];
            
            break;
        }
        view = view.superview;
    }
    
    
//    [self.view.window addSubview:_yearMonthIntervalPicker];
//    [self.view.window bringSubviewToFront:_yearMonthIntervalPicker];
//    [_yearMonthIntervalPicker setNeedsDisplay];;
    
//    UIView *view1 = [[UIView alloc] initWithFrame:self.view.frame];
//    [self.tableView.window addSubview:view1];
//    [self.tableView.window bringSubviewToFront:view1];
    
    NSLog(@"######");
}

- (IBAction)inputMoneyButtonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    _selectedButton = sender;
    
    UIView *view = sender.superview;
    while (view && view.superview) {
        if ([view isKindOfClass:[UITableViewCell class]]) {
            NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)view];
            NSLog(@"indexPath.row = %lu", (long)indexPath.row);
            
            return;
        }
        view = view.superview;
    }
}

- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender {
    NSLog(@"sender.selectedSegmentIndex = %lu title = %@", (long)sender.selectedSegmentIndex, [sender titleForSegmentAtIndex:sender.selectedSegmentIndex]);
    
    [self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
