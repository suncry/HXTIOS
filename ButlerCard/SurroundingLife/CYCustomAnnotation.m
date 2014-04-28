//
//  CYCustomAnnotation.m
//  ButlerCard
//
//  Created by niko on 14-4-28.
//  Copyright (c) 2014年 johnny. All rights reserved.
//

#import "CYCustomAnnotation.h"

@implementation CYCustomAnnotation
@synthesize coordinate, title, subtitle;

-(id) initWithCoordinate:(CLLocationCoordinate2D) coords
{
    if (self = [super init]) {
        coordinate = coords;
    }
    return self;
}

@end
