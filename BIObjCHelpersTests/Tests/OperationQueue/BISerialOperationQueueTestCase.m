//
//  BISerialOperationQueueTestCase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/3/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BISerialOperationQueue.h"

@interface BISerialOperationQueueTestCase : XCTestCase

@property (nonatomic, strong) BISerialOperationQueue *serialOperationQueue;

@end

@implementation BISerialOperationQueueTestCase

- (void)setUp {
    [super setUp];
    self.serialOperationQueue = [BISerialOperationQueue new];
}

- (void)tearDown {
    self.serialOperationQueue = nil;
    [super tearDown];
}

- (void)testWith2Operations {
    XCTestExpectation *expectation1 = [self expectationWithDescription:@"Wait for operation 1 to finish"];
    XCTestExpectation *expectation2 = [self expectationWithDescription:@"Wait for operation 2 to finish"];

    __block NSOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        useconds_t secondsToSleep = 5;
        useconds_t microToSecondsMultiplier = 1000;
        useconds_t total = secondsToSleep * microToSecondsMultiplier;
        usleep(total);
        [expectation1 fulfill];
    }];

    NSOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        XCTAssert(operation1.isFinished);
        [expectation2 fulfill];
    }];

    [self.serialOperationQueue addOperation:operation1];
    [self.serialOperationQueue addOperation:operation2];
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

@end
