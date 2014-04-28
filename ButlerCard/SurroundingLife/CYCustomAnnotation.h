//
//  CYCustomAnnotation.h
//  ButlerCard
//
//  Created by niko on 14-4-28.
//  Copyright (c) 2014年 johnny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CYCustomAnnotation : NSObject<MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
}
-(id) initWithCoordinate:(CLLocationCoordinate2D) coords;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

// Called as a result of dragging an annotation view.
//- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate NS_AVAILABLE(10_9, 4_0);

@end
