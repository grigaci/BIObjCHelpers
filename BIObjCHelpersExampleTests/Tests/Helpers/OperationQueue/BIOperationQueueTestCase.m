//
//  BIOperationQueueTestCase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/2/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BIOperationQueue.h"

@interface BIOperationQueueTestCase : XCTestCase

@property (nonatomic, strong) BIOperationQueue *operationQueue;

@end

@implementation BIOperationQueueTestCase

- (void)setUp {
    [super setUp];
    self.operationQueue = [BIOperationQueue new];
}

- (void)tearDown {
    self.operationQueue = nil;
    [super tearDown];
}

- (void)testAddOperationNilParam {
    XCTAssertThrows([self.operationQueue addOperation:nil]);
}

- (void)testAddOperationsWaitUntilFinishedNilParam {
    XCTAssertThrows([self.operationQueue addOperations:nil waitUntilFinished:YES]);
}

- (void)testAddOperationsWaitUntilFinishedEmptyArray {
    XCTAssertThrows([self.operationQueue addOperations:@[] waitUntilFinished:YES]);
}

- (void)testFinishedCallbackNil {
    [self.operationQueue addOperationWithBlock:^{
        NSLog(@"Testing...");
    }];
    [self.operationQueue waitUntilAllOperationsAreFinished];
    XCTAssert(YES, "Testing that it should not crash after the operation is finished when the callback is nil");
}

- (void)testFinishedCallbackValid {
    __block BOOL wasCalled = NO;
    XCTestExpectation *expectation = [self expectationWithDescription:@"Waiting for finished callback"];
    self.operationQueue.finishedCallback = ^(){
        wasCalled = YES;
        [expectation fulfill];
    };

    [self.operationQueue addOperationWithBlock:^{
        NSLog(@"Testing...");
    }];

    [self waitForExpectationsWithTimeout:10 handler:nil];
    XCTAssert(wasCalled);
}

@end
