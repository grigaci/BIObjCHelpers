//
//  BIStartersFactoryTestCase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/13/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIStartersFactory.h"
#import "BIStarterProtocol.h"
#import "BIMockStarter.h"

@interface BIStartersFactoryTestCase : XCTestCase

@end

@implementation BIStartersFactoryTestCase

#pragma mark - Test run method

- (void)testRunningStarter {
    __block NSInteger starterIndex = 0;
    BIMockStarter *firstStarter = [BIMockStarter new];
    firstStarter.startCallback = ^() {
        XCTAssertEqual(starterIndex, 0U); // Should be the first one called
        starterIndex++;
    };

    BIMockStarter *secondStarter = [BIMockStarter new];
    secondStarter.startCallback = ^() {
        XCTAssertEqual(starterIndex, 1U); // Should be the second one called
        starterIndex++;
    };

    BIStartersFactory *factory = [BIStartersFactory new];
    [factory addStarter:firstStarter];
    [factory addStarter:secondStarter];

    [factory run];
    XCTAssertEqual(starterIndex, 2U); // Should have 2 calls
}

#pragma mark - Test addStarter method

- (void)testAddStarterWithNil {
    BIStartersFactory *factory = [BIStartersFactory new];
    XCTAssertThrows([factory addStarter:nil]);
}

@end
