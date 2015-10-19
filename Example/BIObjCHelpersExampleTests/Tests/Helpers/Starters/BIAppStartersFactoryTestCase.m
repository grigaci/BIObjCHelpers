//
//  BIAppStartersFactoryTestCase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/12/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIAppStartersFactory.h"

#import <XCTest/XCTest.h>
#import <MagicalRecord/MagicalRecord.h>

@interface BIAppStartersFactoryTestCase : XCTestCase

@end

@implementation BIAppStartersFactoryTestCase

- (void)test_run {
    [[BIAppStartersFactory new] run];
    NSPersistentStoreCoordinator *persistanceStore = [NSPersistentStoreCoordinator MR_defaultStoreCoordinator];
    XCTAssert(persistanceStore);
}

@end
