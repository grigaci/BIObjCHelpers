//
//  BILifecycleTestCase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 04/05/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BILifecycle.h"

#import <XCTest/XCTest.h>

@interface BILifecycleTestCase : XCTestCase

@end

@implementation BILifecycleTestCase


#pragma mark - Test load method

- (void)testLoad {
    BILifecycle *lifecycle = [BILifecycle new];
    XCTAssertFalse(lifecycle.isLoaded);
    
    // Testing that calling n times the load method will give the same output and that it doesn't crash
    NSUInteger counter = arc4random_uniform(20);
    for (NSUInteger index; index < counter; index++) {
        [lifecycle load];
        XCTAssertTrue(lifecycle.isLoaded);
    }
}

#pragma mark - Test unload method

- (void)testUnload {
    BILifecycle *lifecycle = [BILifecycle new];
    [lifecycle load];
    
    // Testing that calling n times the unload method will give the same output and that it doesn't crash
    NSUInteger counter = arc4random_uniform(20);
    for (NSUInteger index; index < counter; index++) {
        [lifecycle unload];
        XCTAssertFalse(lifecycle.isLoaded);
    }
}

@end
