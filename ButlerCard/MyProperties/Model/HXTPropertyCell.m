//
//  HXTPropertyCell.m
//  ButlerCard
//
//  Created by johnny tang on 3/10/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTPropertyCell.h"

@interface HXTPropertyCell ()

@end

@implementation HXTPropertyCell

- (id)init {
    self = [super init];
    if (self) {
        _house = [[HXTHouse alloc] init];
        _fees = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return self;
}
@end
