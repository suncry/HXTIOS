//
//  CYSurroundingLifeController.h
//  ButlerCard
//
//  Created by niko on 14-4-22.
//  Copyright (c) 2014年 johnny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYSurroundingLifeController : UITableViewController<UISearchDisplayDelegate,UISearchBarDelegate>
{
    UISearchDisplayController *_cySearchDisplayController;
    UISearchBar *_cySearchBar;
}
@property (weak, nonatomic) IBOutlet UIButton *styleBtn;
- (IBAction)styleBtnClick:(id)sender;
- (IBAction)seachBtnClick:(id)sender;

@end
