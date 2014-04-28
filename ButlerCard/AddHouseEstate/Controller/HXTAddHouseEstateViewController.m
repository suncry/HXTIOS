//
//  HXTAddHouseEstateViewController.m
//  ButlerCard
//
//  Created by johnny tang on 2/21/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTAddHouseEstateViewController.h"
#import "HXTAccountManager.h"
#import "HXTMyProperties.h"

@interface HXTAddHouseEstateViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *chooseAreaBarButtonItem;
@property (weak, nonatomic) IBOutlet UIControl *coverView;
@property (weak, nonatomic) IBOutlet UISearchBar *propertySearchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *housingEstatesCollectionView;

@property (copy, nonatomic) NSMutableArray *housingEstateNamesToShow;
@property (strong, nonatomic)HXTHouse *addedHouse;
@end

@implementation HXTAddHouseEstateViewController

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
    
    _housingEstateNamesToShow = [[NSMutableArray alloc] initWithArray:[HXTMyProperties sharedInstance].allHousingEstateNames];
    _addedHouse = [[HXTHouse alloc] init];
    
    _chooseAreaBarButtonItem.title = [[HXTAccountManager sharedInstance].currentArea stringByAppendingString:@" ▾"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[HXTAccountManager sharedInstance] addObserver:self
                                         forKeyPath:@"currentArea"
                                            options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                                            context:NULL];
}

- (void)viewWillDisappear:(BOOL)animated {
    [_propertySearchBar resignFirstResponder];
    [[HXTAccountManager sharedInstance] removeObserver:self forKeyPath:@"currentArea"];
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - key value abserver

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"currentArea"] && object == [HXTAccountManager sharedInstance]) {
        _chooseAreaBarButtonItem.title = [[HXTAccountManager sharedInstance].currentArea stringByAppendingString:@" ▾"];
    }
}

#pragma mark - UISearchBar Delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.view bringSubviewToFront:_coverView];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"1searchBar.text = %@ searchText = %@", searchBar.text, searchText);
    [self startSearch:searchBar.text];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self.view sendSubviewToBack:_coverView];
    NSLog(@"3searchBar.text = %@", searchBar.text);
}

- (void)startSearch:(NSString *)searchString {
    if (searchString == nil || (id)searchString==[NSNull null] ||
        searchString.length <= 0 || [searchString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length<=0) {
        [_housingEstateNamesToShow addObjectsFromArray:[HXTMyProperties sharedInstance].allHousingEstateNames];
    } else {
        [_housingEstateNamesToShow removeAllObjects];
        for (NSUInteger i = 0; i < [HXTMyProperties sharedInstance].allHousingEstateNames.count; i++) {
            NSRange range = [[HXTMyProperties sharedInstance].allHousingEstateNames[i] rangeOfString:searchString];
            if (range.location != NSNotFound) {
                [_housingEstateNamesToShow addObject:[HXTMyProperties sharedInstance].allHousingEstateNames[i]];
            }
        }
    }
    
    [_housingEstatesCollectionView reloadData];
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _housingEstateNamesToShow.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *collectionViewCellIdentifier= @"CollectionViewCellIdentifier";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];
    ((UIImageView *)[cell viewWithTag:100]).image = [UIImage imageNamed:[NSString stringWithFormat:@"property_house%lu", (long)(indexPath.row % 7 + 1)]];
    ((UILabel *)[cell viewWithTag:101]).text = _housingEstateNamesToShow[indexPath.row];
    
    return cell;
}


#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectItemAtIndexPath indexPath.section = %li, indexPath.row = %li", (long)indexPath.section, (long)indexPath.row);
    _addedHouse.housingEstatename = _housingEstateNamesToShow[indexPath.row];
    /*
     UIViewController *loginViewcontroller = [[UIStoryboard storyboardWithName:@"AccountManager" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginStoryboardID"];
     
     [loginViewcontroller setValue:self forKey:@"delegate"];
     [self.navigationController pushViewController:loginViewcontroller animated:YES];
     */
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - IB Actions

- (IBAction)backgroudTouchUpInside:(id)sender {
    [_propertySearchBar resignFirstResponder];
    [self.view sendSubviewToBack:_coverView];
}

- (IBAction)appleyOpenPropertyButtonPressed:(id)sender {
    NSLog(@"appleyOpenPropertyButtonPressed");
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddHouseStoryboardSegue"]) {
        UIViewController *addHouseViewController = segue.destinationViewController;
        [addHouseViewController setValue:_addedHouse forKey:@"addedHouse"];
    }
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
