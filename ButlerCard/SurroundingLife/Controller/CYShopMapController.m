//
//  CYShopMapController.m
//  ButlerCard
//
//  Created by niko on 14-4-28.
//  Copyright (c) 2014年 johnny. All rights reserved.
//

#import "CYShopMapController.h"
#import "CYCustomAnnotation.h"
@interface CYShopMapController ()

@end

@implementation CYShopMapController

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
    
//    _shopMap = [[MKMapView alloc] initWithFrame:[self.view bounds]];
    //显示地图
    _shopMap.showsUserLocation = YES;
    _shopMap.mapType = MKMapTypeStandard;
    [self.view addSubview:_shopMap];
    //定位
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(39.915352,116.397105);
    float zoomLevel = 0.02;
    MKCoordinateRegion region = MKCoordinateRegionMake(coords, MKCoordinateSpanMake(zoomLevel, zoomLevel));
    [_shopMap setRegion:[_shopMap regionThatFits:region] animated:YES];
    //放大头针
    [self createAnnotationWithCoords:coords];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)createAnnotationWithCoords:(CLLocationCoordinate2D) coords
{
    CYCustomAnnotation *annotation = [[CYCustomAnnotation alloc] initWithCoordinate:
                                    coords];
    annotation.title = @"标题";
    annotation.subtitle = @"子标题";
    [_shopMap addAnnotation:annotation];
}

@end
