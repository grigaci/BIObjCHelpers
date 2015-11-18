//
//  BIDatasourceBaseTestCase.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 18/11/15.
//  Copyright © 2015 iGama Apps. All rights reserved.
//

#import "BIDatasourceBase.h"

#import <XCTest/XCTest.h>

@interface BIDatasourceBaseTestCase : XCTestCase

@end

@implementation BIDatasourceBaseTestCase

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark - Test init

- (void)test_init {
    BIDatasourceBase *datasource = [BIDatasourceBase new];
    XCTAssertNotNil(datasource);
    XCTAssertNotNil(datasource.operations);
    XCTAssertEqual(datasource.operations.count, 0U);
}

@end
