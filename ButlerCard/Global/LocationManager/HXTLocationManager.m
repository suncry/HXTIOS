//
//  HXTLocationManager.m
//  ButlerCard
//
//  Created by johnny tang on 3/26/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTLocationManager.h"

@interface HXTLocationManager () <CLLocationManagerDelegate>

@property (nonatomic, assign) CLLocationCoordinate2D lastCoordinate;
@property (nonatomic, strong) NSString *lastCity;
@property (nonatomic, strong) NSString *lastAddress;
@property (nonatomic, strong) NSString *lastSubLocality;
@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;

@property (nonatomic, strong) LocationBlock locationBlock;
@property (nonatomic, strong) NSStringBlock cityBlock;
@property (nonatomic, strong) NSStringBlock addressBlock;
@property (nonatomic, strong) NSStringBlock subLocalityBlock;
@property (nonatomic, strong) LocationErrorBlock errorBlock;

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation HXTLocationManager

+ (instancetype)sharedLocation;
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void) getLocationCoordinate:(LocationBlock) locaiontBlock
{
    self.locationBlock = [locaiontBlock copy];
    [self startLocation];
}

- (void) getLocationCoordinate:(LocationBlock) locaiontBlock  withAddress:(NSStringBlock) addressBlock
{
    self.locationBlock = [locaiontBlock copy];
    self.addressBlock = [addressBlock copy];
    [self startLocation];
}

- (void) getAddress:(NSStringBlock)addressBlock
{
    self.addressBlock = [addressBlock copy];
    [self startLocation];
}

- (void) getCity:(NSStringBlock)cityBlock
{
    self.cityBlock = [cityBlock copy];
    [self startLocation];
}

- (void) getCity:(NSStringBlock)cityBlock error:(LocationErrorBlock) errorBlock
{
    self.cityBlock = [cityBlock copy];
    self.errorBlock = [errorBlock copy];
    [self startLocation];
}

- (void) getSubLocality:(NSStringBlock)addressBlock {
    self.subLocalityBlock = [addressBlock copy];
    [self startLocation];
}

#pragma mark - CLLocationManager delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    self.lastCoordinate = newLocation.coordinate;
    
    NSLog(@"%f, %f", self.lastCoordinate.latitude, self.lastCoordinate.longitude);
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    
    [geoCoder reverseGeocodeLocation:newLocation
                   completionHandler:^(NSArray *placemarks,NSError *error) {
                       
                       for (CLPlacemark * placeMark in placemarks)
                       {
                           self.lastCity = placeMark.locality;
                           self.lastAddress = placeMark.name;
                           self.lastSubLocality = placeMark.subLocality;
                           
                           
                           NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
                           
                           NSLog(@"placeMark.name = %@", placeMark.name);
                           NSLog(@"placeMark.thoroughfare = %@", placeMark.thoroughfare);
                           NSLog(@"placeMark.subThoroughfare = %@", placeMark.subThoroughfare);
                           NSLog(@"placeMark.locality = %@", placeMark.locality);
                           NSLog(@"placeMark.subLocality = %@", placeMark.subLocality);
                           NSLog(@"placeMark.administrativeArea = %@", placeMark.administrativeArea);
                           NSLog(@"placeMark.subAdministrativeArea = %@", placeMark.subAdministrativeArea);
                           NSLog(@"placeMark.postalCode = %@", placeMark.postalCode);
                           NSLog(@"placeMark.ISOcountryCode = %@", placeMark.ISOcountryCode);
                           NSLog(@"placeMark.country = %@", placeMark.country);
                           NSLog(@"placeMark.inlandWater = %@", placeMark.inlandWater);
                           NSLog(@"placeMark.ocean = %@", placeMark.ocean);
                           NSLog(@"placeMark.areasOfInterest = %@", placeMark.areasOfInterest);
                           
                       }
                       
                       if (_cityBlock) {
                           _cityBlock(_lastCity);
                           _cityBlock = nil;
                       }
                       
                       if (_locationBlock) {
                           _locationBlock(_lastCoordinate);
                           _locationBlock = nil;
                       }
                       
                       if (_addressBlock) {
                           _addressBlock(_lastAddress);
                           _addressBlock = nil;
                       }
                       
                       if (_subLocalityBlock) {
                           _subLocalityBlock(_lastSubLocality);
                       }
                       
                       [self stopLocation];
                   }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%s %s %d %@", __FILE__, __FUNCTION__, __LINE__, [error localizedDescription]);
    if (_errorBlock) {
        _errorBlock(error);
        _errorBlock = nil;
    }
    
    [self stopLocation];
}

#pragma mark - location functions

-(void)startLocation
{
    // check to see if Location Services is enabled, there are two state possibilities:
    // 1) disabled for entire device, 2) disabled just for this app
    //
    NSString *causeStr = nil;
    
    // check whether location services are enabled on the device
    if ([CLLocationManager locationServicesEnabled] == NO)
    {
        causeStr = @"device";
    }
    // check the application’s explicit authorization status:
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        causeStr = @"app";
    }
    else
    {
        // we are good to go, start the location
        if (_locationManager) {
            _locationManager = nil;
        }
        
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        [_locationManager startUpdatingLocation];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
    
    if (causeStr != nil)
    {
        NSString *alertMessage = [NSString stringWithFormat:@"You currently have location services disabled for this %@. Please refer to \"Settings\" app to turn on Location Services.", causeStr];
        
        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled"
                                                                        message:alertMessage
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
        [servicesDisabledAlert show];
    }
}

-(void)stopLocation
{
    [_locationManager stopUpdatingLocation];
    _locationManager = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
