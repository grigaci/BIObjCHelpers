//
//  BIModelBaseTestCase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/9/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BITestCaseCoreData.h"
#import "BIModelBase.h"

@interface BIModelBaseTestCase : BITestCaseCoreData

@end

@implementation BIModelBaseTestCase

#pragma mark - Test insertInManagedObjectContext: method
- (void)testInsertInManagedObjectContextWithInvalidParam {
    XCTAssertThrows([BIModelBase insertInManagedObjectContext:nil]);
}

- (void)testInsertInManagedObjectContextWithValidParam {
    XCTAssertThrows([BIModelBase insertInManagedObjectContext:self.managedObjectContext], @"Should not be able to create an object from base class");
}

#pragma mark - Test entityName method

- (void)testEntityName {
    XCTAssertThrows([BIModelBase entityName], @"Should not be able to class this method on the base class.");
}

#pragma mark - Test entityInManagedObjectContext: method

- (void)testEntityInManagedObjectContextWithInvalidParam {
    XCTAssertThrows([BIModelBase entityInManagedObjectContext:nil]);
}

- (void)testEntityInManagedObjectContextWithValidParam {
    XCTAssertThrows([BIModelBase entityInManagedObjectContext:self.managedObjectContext], @"Should not be able to get an valid entity!");
}

@end
