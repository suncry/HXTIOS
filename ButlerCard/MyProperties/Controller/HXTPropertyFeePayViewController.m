//
//  HXTPropertyFeePayViewController.m
//  ButlerCard
//
//  Created by johnny tang on 4/18/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import "HXTPropertyFeePayViewController.h"

#import "HXTYearMonthIntervalPickerView.h"

@interface HXTPropertyFeePayViewController () <UITextFieldDelegate, HXTYearMonthIntervalPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (strong, nonatomic) UIControl *coverView;
@property (strong, nonatomic) NSArray *feeTypeName;
@property (strong, nonatomic) HXTYearMonthIntervalPickerView *yearMonthIntervalPicker;
@property (strong, nonatomic) UITextField *editingTextField;
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
//    [_backButton setTitle:[NSString fontAwesomeIconStringForIconIdentifier:@"icon-remove"] forState:UIControlStateNormal];
    _feeTypeName = @[@"物管费", @"停车费", @"水费", @"电费", @"气费"];
    
    _yearMonthIntervalPicker = [[[NSBundle mainBundle] loadNibNamed:@"HXTYearMonthIntervalPickerView" owner:self options:nil] lastObject];
    _yearMonthIntervalPicker.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    _coverView = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view.window addSubview:_coverView];
    [self.view.window bringSubviewToFront:_coverView];
    _coverView.hidden = YES;
    _coverView.backgroundColor = [UIColor clearColor];
//    _coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2f];
    [_coverView addTarget:self action:@selector(backgroundTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        ((UIButton *)[cell viewWithTag:101]).selected = YES;
        ((UILabel *)[cell viewWithTag:102]).text = _feeTypeName[indexPath.row];
        
        return cell;
    } else {
        if (indexPath.row < 2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TypeTwoCellIdentifier forIndexPath:indexPath];
            
            // Configure the cell...
            
            ((UILabel *)[cell viewWithTag:102]).text = _feeTypeName[indexPath.row];
        
            ((UITextField *)[cell viewWithTag:103]).inputView = _yearMonthIntervalPicker;
            ((UITextField *)[cell viewWithTag:103]).delegate = self;
            ((UITextField *)[cell viewWithTag:105]).inputView = _yearMonthIntervalPicker;
            ((UITextField *)[cell viewWithTag:105]).delegate = self;
            
            return cell;
        } else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TypeThreeCellIdentifier forIndexPath:indexPath];
            
            // Configure the cell...
            
            ((UILabel *)[cell viewWithTag:102]).text = _feeTypeName[indexPath.row];
            ((UITextField *)[cell viewWithTag:103]).inputView = _yearMonthIntervalPicker;
            ((UITextField *)[cell viewWithTag:103]).delegate = self;
            
            return cell;
        }
    }
}

#pragma mark - text field delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    _coverView.hidden = NO;
    _editingTextField = textField;
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

#pragma mark - HXTYearMonthIntervalPickerView delegate

- (void)pickerDidSelectStarYear:(NSUInteger)startYear andStartMonth:(NSUInteger)startMonth
                     andEndYear:(NSUInteger)endYear andEndMonth:(NSUInteger)endMonth
{
    
}

- (void)pickerDidPressDoneWithStarYear:(NSUInteger)startYear andStartMonth:(NSUInteger)startMonth
                            andEndYear:(NSUInteger)endYear andEndMonth:(NSUInteger)endMonth {
    [_editingTextField resignFirstResponder];
    _coverView.hidden = YES;
    
}
- (void)pickerDidPressCancel {
    [_editingTextField resignFirstResponder];
    _coverView.hidden = YES;
    
}


#pragma mark - LTHMonthYearPickerView Delegate

- (void)pickerDidPressCancelWithInitialValues:(NSDictionary *)initialValues {
	_editingTextField.text = [NSString stringWithFormat:
						   @"%@年%@月",
                              initialValues[@"year"],
                              initialValues[@"month"]];
    [_editingTextField resignFirstResponder];
    _coverView.hidden = YES;
}


- (void)pickerDidPressDoneWithMonth:(NSString *)month andYear:(NSString *)year {
    _editingTextField.text = [NSString stringWithFormat: @"%@年%@月",year, month];
	[_editingTextField resignFirstResponder];
    _coverView.hidden = YES;
}


- (void)pickerDidSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	NSLog(@"row: %li in component: %li", (long)row, (long)component);
}


- (void)pickerDidSelectMonth:(NSString *)month {
    NSLog(@"month: %@ ", month);
}


- (void)pickerDidSelectYear:(NSString *)year {
    NSLog(@"year: %@ ", year);
}


- (void)pickerDidSelectMonth:(NSString *)month andYear:(NSString *)year {
    _editingTextField.text = [NSString stringWithFormat: @"%@年%@月",year, month];
}

#pragma mark - local functions
- (void)backgroundTouchUpInside:(id)sender {
    if (_editingTextField) {
        [_editingTextField resignFirstResponder];
    }
    _coverView.hidden = YES;
}

#pragma mark - IB Actions


- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender {
    NSLog(@"sender.selectedSegmentIndex = %lu title = %@", (long)sender.selectedSegmentIndex, [sender titleForSegmentAtIndex:sender.selectedSegmentIndex]);
    
    [self.tableView reloadData];
}

- (IBAction)chechBoxChecked:(UIButton *)sender {
    sender.selected = !sender.selected;
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

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}
@end
