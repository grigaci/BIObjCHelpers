//
//  BIOperationBaseTestCase.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 5/31/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <BIObjCHelpers/BIObjCHelpers.h>

@interface BIOperationBaseTestCase : XCTestCase

@property (nonatomic, strong, nullable, readwrite) BIOperationBase *operation;

@end

@implementation BIOperationBaseTestCase

#pragma mark - Setup methods

- (void)setUp {
    [super setUp];
    self.operation = [BIOperationBase new];
}

#pragma mark - Test start

- (void)test_start {
    [self.operation start];
    XCTAssertTrue(self.operation.isExecuting);
    XCTAssertFalse(self.operation.isFinished);
    XCTAssertTrue(self.operation.runCallbacksOnMainThread);
}

#pragma mark - Test finish

- (void)test_finish {
    [self.operation start];
    [self.operation finish];
    XCTAssertFalse(self.operation.isExecuting);
    XCTAssertTrue(self.operation.isFinished);
}

#pragma mark - Test handleDidFinishedWithResponse

- (void)test_handleDidFinishedWithResponseMainThread {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Call"];
    __block NSNumber *receivedResponse;
    self.operation.didFinishSuccessfullyCallback = ^(NSNumber *response) {
        receivedResponse = response;
        [expectation fulfill];
    };
    [self.operation start];
    NSNumber *sentReponse = @(YES);
    [self.operation handleDidFinishedWithResponse:sentReponse];
    [self waitForExpectationsWithTimeout:2 handler:nil];
    XCTAssertEqualObjects(receivedResponse, sentReponse);
}

- (void)test_handleDidFinishedWithResponseGlobalQueue {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Call"];
    __block NSNumber *receivedResponse;
    self.operation.didFinishSuccessfullyCallback = ^(NSNumber *response) {
        receivedResponse = response;
        [expectation fulfill];
    };
    [self.operation start];
    NSNumber *sentReponse = @(YES);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.operation handleDidFinishedWithResponse:sentReponse];
    });
    [self waitForExpectationsWithTimeout:2 handler:nil];
    XCTAssertEqualObjects(receivedResponse, sentReponse);
}

#pragma mark - Test handleDidFinishedWithError

- (void)test_handleDidFinishedWithErrorMainThread {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Call"];
    __block NSError *receivedError;
    self.operation.didFinishWithErrorCallback = ^(NSError *error) {
        receivedError = error;
        [expectation fulfill];
    };
    [self.operation start];
    NSError *sentError = [NSError errorWithDomain:@"test domain" code:100 userInfo:nil];
    [self.operation handleDidFinishedWithError:sentError];
    [self waitForExpectationsWithTimeout:2 handler:nil];
    XCTAssertEqualObjects(receivedError, sentError);
}

- (void)test_handleDidFinishedWithErrorGlobalQueue {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Call"];
    __block NSError *receivedError;
    self.operation.didFinishWithErrorCallback = ^(NSError *error) {
        receivedError = error;
        [expectation fulfill];
    };
    [self.operation start];
    NSError *sentError = [NSError errorWithDomain:@"test domain" code:100 userInfo:nil];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.operation handleDidFinishedWithError:sentError];
    });

    [self waitForExpectationsWithTimeout:2 handler:nil];
    XCTAssertEqualObjects(receivedError, sentError);
}

#pragma mark - Test handleDidFinishedCommon

- (void)test_handleDidFinishedCommonSuccess {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Call"];
    __block BOOL wasCalled = NO;
    self.operation.didFinishCommonCallback = ^() {
        wasCalled = YES;
        [expectation fulfill];
    };
    [self.operation start];
    [self.operation handleDidFinishedWithResponse:@(YES)];
    [self waitForExpectationsWithTimeout:2 handler:nil];
    XCTAssertTrue(wasCalled);
    XCTAssertFalse(self.operation.isExecuting);
    XCTAssertTrue(self.operation.isFinished);
}

- (void)test_handleDidFinishedCommonError {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Call"];
    __block BOOL wasCalled = NO;
    self.operation.didFinishCommonCallback = ^() {
        wasCalled = YES;
        [expectation fulfill];
    };
    [self.operation start];
    NSError *sentError = [NSError errorWithDomain:@"test domain" code:100 userInfo:nil];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.operation handleDidFinishedWithError:sentError];
    });
    
    [self waitForExpectationsWithTimeout:2 handler:nil];
    XCTAssertTrue(wasCalled);
    XCTAssertFalse(self.operation.isExecuting);
    XCTAssertTrue(self.operation.isFinished);
}

@end
