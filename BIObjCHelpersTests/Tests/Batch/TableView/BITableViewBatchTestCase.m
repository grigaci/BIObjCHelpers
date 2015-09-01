//
//  BITableViewBatchTestCase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 14/07/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIBatch.h"

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface BITableViewBatchTestCase : XCTestCase

@end

@implementation BITableViewBatchTestCase

#pragma mark - Test init methods

- (void)testInitParams {
    BIBatch *batch = [[BIBatch alloc] initWithCompletionBlock:nil];
    XCTAssertEqual(batch.sectionIndex, 0);
    XCTAssertEqual(batch.batchSize, kDefaultBatchSize);
}

#pragma mark - Test property methods

- (void)testProperties {
    NSUInteger section = arc4random_uniform(100);
    NSUInteger batchSize = arc4random_uniform(100);
    __block BOOL wasCalled = NO;
    BIBatchCompletionBlock block = ^(NSError * __nullable error, NSArray * __nullable newIndexPaths) {
        wasCalled = YES;
    };
    BIBatch *batch = [[BIBatch alloc] initWithSection:section
                                                              batchSize:batchSize
                                                        completionBlock:block];
    batch.completionBlock(nil, nil);
    XCTAssertEqual(batch.sectionIndex, section);
    XCTAssertEqual(batch.batchSize, batchSize);
    XCTAssertTrue(wasCalled);
}

@end
