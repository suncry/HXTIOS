//
//  HXTPropertyFeePayViewController.m
//  ButlerCard
//
//  Created by johnny tang on 4/18/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import "HXTPropertyFeePayViewController.h"
#import "SRMonthPicker.h"

@interface HXTPropertyFeePayViewController () <UIActionSheetDelegate, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (strong, nonatomic) SRMonthPicker *monthPicker;
@property (strong, nonatomic) NSArray *feeTypeName;
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
    
    _feeTypeName = @[@"物管费", @"停车费", @"水费", @"电费", @"气费"];
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
        
        ((UILabel *)[cell viewWithTag:102]).text = _feeTypeName[indexPath.row];
        
        return cell;
    } else {
        if (indexPath.row < 2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TypeTwoCellIdentifier forIndexPath:indexPath];
            
            // Configure the cell...
            
            ((UILabel *)[cell viewWithTag:102]).text = _feeTypeName[indexPath.row];
            
            return cell;
        } else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TypeThreeCellIdentifier forIndexPath:indexPath];
            
            // Configure the cell...
            
            ((UILabel *)[cell viewWithTag:102]).text = _feeTypeName[indexPath.row];
            
            return cell;
        }
    }
}

#pragma mark - IB Actions

- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender {
    NSLog(@"sender.selectedSegmentIndex = %lu title = %@", (long)sender.selectedSegmentIndex, [sender titleForSegmentAtIndex:sender.selectedSegmentIndex]);
    [self.tableView reloadData];
}

- (IBAction)chechBoxChecked:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)lowerDateSelectorButtonPressed:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                               
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    [actionSheet setBounds:CGRectMake(0,0,320, 385)];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 430)];
    _monthPicker = [[SRMonthPicker alloc] initWithFrame:CGRectMake(0, 0, 320, 165)];
    _monthPicker.maximumYear = @2015;
    _monthPicker.minimumYear = @2013;
    _monthPicker.yearFirst = YES;
    [backgroundView addSubview:_monthPicker];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 170, 280, 40);
    [button setBackgroundImage:[UIImage imageNamed:@"account_sigh_button_tjxq"] forState:UIControlStateNormal];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [backgroundView addSubview:button];
    
    [actionSheet addSubview:backgroundView];
    backgroundView.backgroundColor = [UIColor colorWithRed:241.0f / 255 green:241.0f / 255 blue:241.0f / 255 alpha:1];
    [actionSheet bringSubviewToFront:backgroundView];
    
}

- (IBAction)uperDateSelectorButtonPressed:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确认" otherButtonTitles:@"11", @"22", @"33", nil];
    [actionSheet showInView:self.view];
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
