//
//  BILaunchStartersFactoryTestCase.m
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 10/13/15.
//  Copyright © 2015 iGama Apps. All rights reserved.
//

#import "BIStarterProtocol.h"
#import "BILaunchStartersFactory.h"
#import "BIMockStarter.h"

#import <XCTest/XCTest.h>

@interface BILaunchStartersFactoryTestCase : XCTestCase

@end

@implementation BILaunchStartersFactoryTestCase

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
    
    NSDictionary *launchOptions = @{@"test" : @"test"};
    
    BILaunchStartersFactory *factory = [[BILaunchStartersFactory alloc] initWithLaunchingOptions:launchOptions];
    [factory addStarter:firstStarter];
    [factory addStarter:secondStarter];
    
    [factory run];
    XCTAssertEqual(starterIndex, 2U); // Should have 2 calls
    XCTAssertEqual(launchOptions, firstStarter.launchOptions);
    XCTAssertEqual(secondStarter.launchOptions, firstStarter.launchOptions);
    
}

@end
