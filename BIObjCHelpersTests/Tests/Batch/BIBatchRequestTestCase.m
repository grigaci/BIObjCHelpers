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

#pragma mark - Test copy

- (void)test_copy {
    BIBatchRequest *request1 = [[BIBatchRequest alloc] initWithSection:1
                                                             batchSize:23
                                                       completionBlock:nil];
    BIBatchRequest *request2 = [request1 copy];
    XCTAssertEqual(request1.sectionIndex, request2.sectionIndex);
    XCTAssertEqual(request1.batchSize, request2.batchSize);
    XCTAssertEqual(request1.insertPosition, request2.insertPosition);
    XCTAssertEqual(request1.options, request2.options);
    XCTAssertTrue([request2 isKindOfClass:[BIBatchRequest class]]);
}


#pragma mark - Test copy

- (void)test_mutableCopy {
    BIBatchRequest *request1 = [[BIBatchRequest alloc] initWithSection:0
                                                             batchSize:19
                                                       completionBlock:nil];
    BIMutableBatchRequest *request2 = [request1 mutableCopy];
    XCTAssertEqual(request1.sectionIndex, request2.sectionIndex);
    XCTAssertEqual(request1.batchSize, request2.batchSize);
    XCTAssertEqual(request1.insertPosition, request2.insertPosition);
    XCTAssertEqual(request1.options, request2.options);
    XCTAssertTrue([request2 isKindOfClass:[BIMutableBatchRequest class]]);
}

@end
