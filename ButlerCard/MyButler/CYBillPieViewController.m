//
//  CYBillPieViewController.m
//  ButlerCard
//
//  Created by niko on 14-3-21.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import "CYBillPieViewController.h"
#import "Example2PieView.h"
#import "MyPieElement.h"
#import "PieLayer.h"

@interface CYBillPieViewController ()
@property (nonatomic, weak) IBOutlet Example2PieView* pieView;

@end

@implementation CYBillPieViewController
@synthesize pieView;

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
    for(int year = 2009; year <= 2014; year++){
        MyPieElement* elem = [MyPieElement pieElementWithValue:(5+arc4random()%8) color:[self randomColor]];
        elem.title = [NSString stringWithFormat:@"%d year", year];
        [pieView.layer addValues:@[elem] animated:NO];
    }
    
    //mutch easier do this with array outside
    pieView.layer.transformTitleBlock = ^(PieElement* elem){
        return [(MyPieElement*)elem title];
    };
    pieView.layer.showTitles = ShowTitlesAlways;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIColor*)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
//- (IBAction)backPressed:(id)sender
//{
//    [self dismissModalViewControllerAnimated:YES];
//}

- (IBAction)randomValuesPressed:(id)sender
{
    [PieElement animateChanges:^{
        for(PieElement* elem in pieView.layer.values){
            elem.val = (5+arc4random()%8);
        }
    }];
}

- (IBAction)randomColorPressed:(id)sender
{
    [PieElement animateChanges:^{
        for(PieElement* elem in pieView.layer.values){
            elem.color = [self randomColor];
        }
    }];
}


@end
