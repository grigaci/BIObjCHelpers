//
//  BIBatchRequestTestCase.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 8/09/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIBatchRequest.h"
#import "BIBatchResponse.h"

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface BIBatchRequestTestCase : XCTestCase

@end

@implementation BIBatchRequestTestCase

#pragma mark - Test init methods

- (void)testInitParams {
    BIBatchRequest *batch = [[BIBatchRequest alloc] initWithCompletionBlock:nil];
    XCTAssertEqual(batch.sectionIndex, 0);
    XCTAssertEqual(batch.batchSize, kDefaultBatchRequestSize);
    XCTAssertEqual(batch.insertPosition, BIBatchInsertPositionBottom);
}

#pragma mark - Test property methods

- (void)testProperties {
    NSUInteger section = arc4random_uniform(100);
    NSUInteger batchSize = arc4random_uniform(100);
    __block BOOL wasCalled = NO;
    BIBatchRequestCompletionBlock block = ^(BIBatchResponse *response) {
        wasCalled = YES;
    };
    BIBatchRequest *batch = [[BIBatchRequest alloc] initWithSection:section
                                                          batchSize:batchSize
                                                    completionBlock:block];
    
    BIBatchResponse *response = [BIBatchResponse batchResponseForRequest:batch
                                                                   error:nil
                                                           newIndexPaths:@[]];
    batch.completionBlock(response);
    XCTAssertEqual(batch.sectionIndex, section);
    XCTAssertEqual(batch.batchSize, batchSize);
    XCTAssertTrue(wasCalled);
}

@end
