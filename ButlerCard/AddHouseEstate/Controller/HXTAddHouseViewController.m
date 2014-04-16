//
//  HXTAddHouseViewController.m
//  ButlerCard
//
//  Created by johnny tang on 3/26/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTAddHouseViewController.h"
#import "HXTAccountManager.h"
#import "HXTHouse.h"

@interface HXTAddHouseViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *housePicker;

@end

@implementation HXTAddHouseViewController

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
    
    if (!_addedHouse) {
        _addedHouse = [[HXTHouse alloc] init];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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


#pragma mark - UI Actons

- (IBAction)okButtonPresssed:(id)sender {
    NSString *building = [NSString stringWithFormat:@"%lu栋", (long)[self.housePicker selectedRowInComponent:0] + 1];
    NSString *unit     = [NSString stringWithFormat:@"%lu单元", (long)[self.housePicker selectedRowInComponent:1] + 1];
    
    NSUInteger selectedRow = [self.housePicker selectedRowInComponent:2];
    NSString *houseNo  = [NSString stringWithFormat:@"%lu", (long)(100 * (selectedRow / 2 + 1) + selectedRow + 1)];
    
    _addedHouse.buildingNo = [self.housePicker selectedRowInComponent:0] + 1;
    _addedHouse.unitNo = [self.housePicker selectedRowInComponent:1] + 1;
    _addedHouse.houseNo = (100 * (selectedRow / 2 + 1) + selectedRow + 1);
    NSLog(@"%@%@%@", building, unit, houseNo);
    
    if (!_addedHouse.housingEstatename) {
        _addedHouse.housingEstatename = @"测试添加的小区";
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:kAddHouseNotification
                                                        object:self
                                                      userInfo:@{kHouseEstateName:_addedHouse.housingEstatename,
                                                                 kBuildingNo: @(_addedHouse.buildingNo),
                                                                 kUnitNo: @(_addedHouse.unitNo),
                                                                 kHouseNo: @(_addedHouse.houseNo)}];
    
    [self dismissViewControllerAnimated:YES completion:^{ }];
}

#pragma mark - Navigation

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
