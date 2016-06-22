//
//  BIOperationNotifierTestCase.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 6/22/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <BIObjCHelpers/BIObjCHelpers.h>

#import "MockBIOperationNotifierListener.h"
#import "BIOperationNotifier+Tests.h"

@interface BIOperationNotifierTestCase : XCTestCase

@property (nonatomic, strong, nullable, readwrite) BIOperationNotifier *operation;

@end

@implementation BIOperationNotifierTestCase

- (void)setUp {
    [super setUp];
    self.operation = [BIOperationNotifier new];
}

#pragma mark - Test removeAllListeners

- (void)test_removeAllListeners {
    // GIVEN: An array of listener
    NSInteger countListeners = arc4random_uniform(10);
    NSMutableArray<MockBIOperationNotifierListener *> *listeners = [NSMutableArray new];
    for (NSInteger index = 0; index < countListeners; index++) {
        MockBIOperationNotifierListener *listener = [MockBIOperationNotifierListener new];
        [self.operation registerOperationFinishedListener:listener];
        [listeners addObject:listener];
    }
    // WHEN: calling the removeAllListeners
    [self.operation removeAllListeners];
    // THEN: all listeners should be removed
    XCTAssertEqual(self.operation.operationFinishedListeners.count, 0);
}

@end
