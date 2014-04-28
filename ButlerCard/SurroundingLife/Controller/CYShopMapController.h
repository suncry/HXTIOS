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

@interface CYShopMapController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>
 {
    CLLocationManager *locationManager;
 }
@property (weak, nonatomic) IBOutlet MKMapView *shopMap;
@end
