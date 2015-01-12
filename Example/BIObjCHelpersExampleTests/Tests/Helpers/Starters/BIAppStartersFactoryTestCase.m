//
//  BIAppStartersFactoryTestCase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/12/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import <MagicalRecord/CoreData+MagicalRecord.h>
#import <XCTest/XCTest.h>

#import "BIAppStartersFactory.h"

@interface BIAppStartersFactoryTestCase : XCTestCase

@end

@implementation BIAppStartersFactoryTestCase

- (void)testVerifyCoreDataStackNotLoaded {
    NSPersistentStoreCoordinator *persistanceStore = [NSPersistentStoreCoordinator MR_defaultStoreCoordinator];
    XCTAssert(persistanceStore);
}

- (void)testRun {
    [[BIAppStartersFactory new] run];
    NSPersistentStoreCoordinator *persistanceStore = [NSPersistentStoreCoordinator MR_defaultStoreCoordinator];
    XCTAssert(persistanceStore);
}

@end
