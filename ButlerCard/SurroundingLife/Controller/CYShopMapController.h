//
//  CYShopMapController.h
//  ButlerCard
//
//  Created by niko on 14-4-28.
//  Copyright (c) 2014年 johnny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "HXTAppDelegate.h"

@interface CYShopMapController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>
 {
    CLLocationManager *locationManager;
 }
//用于CoreData
@property (strong,nonatomic) HXTAppDelegate *myDelegate;
@property (weak, nonatomic) IBOutlet MKMapView *shopMap;

@property (retain,nonatomic) NSString *shopName;
@property (retain,nonatomic) NSString *shopAddress;
@property (retain,nonatomic) NSNumber *shopLatitude;
@property (retain,nonatomic) NSNumber *shopLongitude;

@end
