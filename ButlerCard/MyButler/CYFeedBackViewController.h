//
//  CYFeedBackViewController.h
//  ButlerCard
//
//  Created by niko on 14-3-25.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYFeedBackViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *feedBackTextView;
- (IBAction)sendBtnClick:(id)sender;

@end
