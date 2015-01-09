//
//  BICapitalTestCase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/9/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BITestCaseCoreData.h"
#import "NSString+RandomTest.h"

#import "BICapital.h"

@interface BICapitalTestCase : BITestCaseCoreData

@end

@implementation BICapitalTestCase

#pragma mark - Test insertInManagedObjectContext: method

- (void)testInsertInManagedObjectContextSaveError {
    BICapital *capital = [BICapital insertInManagedObjectContext:self.managedObjectContext];
    XCTAssert(capital.uuid);
    
    NSDate *now = [NSDate date];
    NSComparisonResult createdAtResult = [now compare:capital.createdat];
    NSComparisonResult updatedAtResult = [now compare:capital.createdat];
    XCTAssert(createdAtResult == NSOrderedDescending);
    XCTAssert(updatedAtResult == NSOrderedDescending);
    
    NSError *error;
    [self.managedObjectContext save:&error];
    XCTAssert(error, @"Should not be able to save capital without an name!");
}

- (void)testInsertInManagedObjectContextSaved {
    BICapital *capital = [BICapital insertInManagedObjectContext:self.managedObjectContext];
    capital.name = [NSString randomString];

    NSError *error;
    [self.managedObjectContext save:&error];
    XCTAssertFalse(error, @"Should be able to save context!");
}

#pragma mark - Test entityName method

- (void)testEntityName {
    NSString *entityName = [BICapital entityName];
    NSString *stringClass = NSStringFromClass([BICapital class]);
    XCTAssertEqualObjects(entityName, stringClass);
}

#pragma mark - Test entityInManagedObjectContext: method

- (void)testEntityInManagedObjectContextWithValidParam {
    NSString *entityName = [BICapital entityName];
    NSString *stringClass = NSStringFromClass([BICapital class]);

   NSEntityDescription *entity = [BICapital entityInManagedObjectContext:self.managedObjectContext];
    XCTAssertEqualObjects(entity.name, entityName);
    XCTAssertEqualObjects(entity.managedObjectClassName, stringClass);
    XCTAssertFalse(entity.isAbstract);
}

@end
