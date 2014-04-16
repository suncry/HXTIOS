//
//  HXTIGoViewController.m
//  ButlerCard
//
//  Created by johnny tang on 2/21/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTIGoViewController.h"

#define kConvenienceStoreStorySegue    @"ConvenienceStoreStorySegue"
#define kPetStoryboardSegue            @"PetStoryboardSegue"
#define kDiningStorySegue              @"DiningStorySegue"
#define kBeautySalonsStoryboardSegue   @"BeautySalonsStoryboardSegue"
#define kLaundryStoryboardSegue        @"LaundryStoryboardSegue"
#define kAutoBeautyStoryboardSegue     @"AutoBeautyStoryboardSegue"
#define kLivingServicesStoryboardSegue @"LivingServicesStoryboardSegue"

@interface HXTIGoViewController ()
@property (strong, nonatomic) NSDictionary* segueType;
@end

@implementation HXTIGoViewController

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
    
    _segueType = @{kConvenienceStoreStorySegue:    @"便利店",
                   kPetStoryboardSegue:            @"宠物",
                   kDiningStorySegue:              @"餐饮",
                   kBeautySalonsStoryboardSegue:   @"美容美发",
                   kLaundryStoryboardSegue:        @"洗衣",
                   kAutoBeautyStoryboardSegue:     @"汽车美容",
                   kLivingServicesStoryboardSegue: @"生活服务"};
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *destViewController = segue.destinationViewController;
    destViewController.navigationItem.title = _segueType[segue.identifier];
}

@end
