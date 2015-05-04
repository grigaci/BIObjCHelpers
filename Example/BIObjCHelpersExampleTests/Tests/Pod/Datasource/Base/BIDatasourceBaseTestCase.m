//
//  BIDatasourceBaseTestCase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 04/05/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BIDatasourceBase.h"


@interface BIDatasourceBaseTestCase : XCTestCase

@end

@implementation BIDatasourceBaseTestCase

#pragma mark - Test load method

- (void)testLoad {
    BIDatasourceBase *datasource = [BIDatasourceBase new];
    XCTAssertFalse(datasource.isLoaded);
    
    // Testing that calling n times the load method will give the same output and that it doesn't crash
    NSUInteger counter = arc4random_uniform(20);
    for (NSUInteger index; index < counter; index++) {
        [datasource load];
        XCTAssertTrue(datasource.isLoaded);
    }
}

#pragma mark - Test unload method

- (void)testUnload {
    BIDatasourceBase *datasource = [BIDatasourceBase new];
    [datasource load];

    // Testing that calling n times the unload method will give the same output and that it doesn't crash
    NSUInteger counter = arc4random_uniform(20);
    for (NSUInteger index; index < counter; index++) {
        [datasource unload];
        XCTAssertFalse(datasource.isLoaded);
    }
}

@end
