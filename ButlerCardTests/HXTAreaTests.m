//
//  HXTAreaTests.m
//  ButlerCard
//
//  Created by johnny tang on 4/25/14.
//  Copyright (c) 2014 johnny. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HXTAreaModel.h"

@interface HXTAreaTests : XCTestCase

@end

@implementation HXTAreaTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testShow
{
    [[HXTAreaModel sharedInstance] show];
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
