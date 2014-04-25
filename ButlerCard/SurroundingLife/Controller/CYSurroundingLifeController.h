//
//  CYSurroundingLifeController.h
//  ButlerCard
//
//  Created by niko on 14-4-22.
//  Copyright (c) 2014年 johnny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXTAppDelegate.h"
@interface CYSurroundingLifeController : UITableViewController<UISearchDisplayDelegate,UISearchBarDelegate>
{
    UISearchDisplayController *_cySearchDisplayController;
    UISearchBar *_cySearchBar;
    
}
//用于CoreData
@property (strong,nonatomic) HXTAppDelegate *myDelegate;
@property (strong,nonatomic) NSMutableArray *entries;

@property (retain, nonatomic) NSMutableArray *dataArr;
@property (retain, nonatomic) NSMutableArray *searchDataArr;

@property (weak, nonatomic) IBOutlet UIButton *styleBtn;
- (IBAction)styleBtnClick:(id)sender;
- (IBAction)seachBtnClick:(id)sender;
- (IBAction)zhekouBtnClick:(id)sender;
- (IBAction)songhuoBtnClick:(id)sender;

@end
