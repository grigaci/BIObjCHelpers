//
//  BIDatasourceBaseTestCase.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 6/22/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <BIObjCHelpers/BIObjCHelpers.h>

#import "MockBIOperationNotifierListener.h"
#import "BIOperationNotifier+Tests.h"

@interface BIDatasourceBaseTestCase : XCTestCase

@property (nonatomic, strong, nullable, readwrite) BIDatasourceBase *datasource;

@end

@implementation BIDatasourceBaseTestCase

- (void)setUp {
    [super setUp];
    self.datasource = [BIDatasourceBase new];
}

#pragma mark - Test init

- (void)test_init {
    BIDatasourceBase *datasource = [BIDatasourceBase new];
    XCTAssertNotNil(datasource);
    XCTAssertNotNil(datasource.operations);
    XCTAssertEqual(datasource.operations.count, 0U);
}

#pragma mark - Test cancelAllCurrentOperations

- (void)test_cancelAllCurrentOperations_silent {
    // GIVEN: A set of operations
    NSInteger countOperations = arc4random_uniform(10);
    NSMutableArray<BIOperationNotifier *> *operations = [NSMutableArray new];
    __block NSError *returnedError;
    for (NSInteger index = 0; index < countOperations; index++) {
        BIOperationNotifier *operation = [BIOperationNotifier new];
        operation.didFinishWithErrorCallback = ^(NSError *__nonnull error) {
            returnedError = error;
        };
        MockBIOperationNotifierListener *listener = [MockBIOperationNotifierListener new];
        [operation registerOperationFinishedListener:listener];
        [self.datasource.operations addObject:operation];
        [operations addObject:operation];
    }
    // WHEN: cancelAllCurrentOperations method is called
    [self.datasource cancelAllCurrentOperations:YES];
    // THEN: Datasource should have no operations
    XCTAssertEqual(self.datasource.operations.count, 0);
    // THEN: All operations should not have a didFinishWithErrorCallback set
    for (BIOperationNotifier *operation in operations) {
        XCTAssertNil(operation.didFinishWithErrorCallback);
    }
    // THEN: All operations should have no listeners
    for (BIOperationNotifier *operation in operations) {
        XCTAssertEqual(operation.operationFinishedListeners.count, 0);
    }

    // THEN: Operation's didFinishWithErrorCallback should not have been called
    XCTAssertNil(returnedError);
}

- (void)test_cancelAllCurrentOperations_notSilent {
    // GIVEN: A set of operations
    NSInteger countOperations = arc4random_uniform(10);
    NSMutableArray<BIOperationNotifier *> *operations = [NSMutableArray new];
    __block NSError *returnedError;
    for (NSInteger index = 0; index < countOperations; index++) {
        BIOperationNotifier *operation = [BIOperationNotifier new];
        operation.didFinishWithErrorCallback = ^(NSError *__nonnull error) {
            returnedError = error;
        };
        MockBIOperationNotifierListener *listener = [MockBIOperationNotifierListener new];
        [operation registerOperationFinishedListener:listener];
        [self.datasource.operations addObject:operation];
        [operations addObject:operation];
    }
    // WHEN: cancelAllCurrentOperations method is called
    [self.datasource cancelAllCurrentOperations:NO];
    // THEN: Datasource should have no operations
    XCTAssertEqual(self.datasource.operations.count, 0);
    // THEN: All operations should have a didFinishWithErrorCallback set
    for (BIOperationNotifier *operation in operations) {
        XCTAssertNotNil(operation.didFinishWithErrorCallback);
    }
    // THEN: All operations should have listeners
    for (BIOperationNotifier *operation in operations) {
        XCTAssertEqual(operation.operationFinishedListeners.count, 1);
    }
}

@end
