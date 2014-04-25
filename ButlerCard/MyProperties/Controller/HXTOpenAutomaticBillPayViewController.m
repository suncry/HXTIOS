//
//  HXTOpenAutomaticBillPayViewController.m
//  ButlerCard
//
//  Created by johnny tang on 4/25/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import "HXTOpenAutomaticBillPayViewController.h"

@interface HXTOpenAutomaticBillPayViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *feeItemsArray;

@end

@implementation HXTOpenAutomaticBillPayViewController

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
    
    _feeItemsArray = @[@"物管费", @"停车费", @"水费", @"电费", @"气费", @"水费(爸妈家)", @"电费(爸妈家)", @"气费(爸妈家)"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _feeItemsArray.count + 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *feeItemCellIdentifier     = @"FeeItemCellIdentifier";
    static NSString *useProtocolCellIdentifier = @"UseProtocolCellIdentifier";
    
    if (indexPath.row < _feeItemsArray.count)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:feeItemCellIdentifier forIndexPath:indexPath];
        
        UIButton *button = (UIButton *)[cell viewWithTag:100];
        [button setTitle:_feeItemsArray[indexPath.row] forState:UIControlStateNormal];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:useProtocolCellIdentifier forIndexPath:indexPath];
        return cell;
    }
}

#pragma mark - table view delegate

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row < _feeItemsArray.count)
//    {
//        return 44;
//    } else {
//        return 72;
//    }
//}

#pragma IB Actions

- (IBAction)checkBoxButtonPressed:(UIButton *)sender {
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

@end
