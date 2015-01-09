//
//  BICountryTestCase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/9/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BITestCaseCoreData.h"
#import "NSString+RandomTest.h"
#import "BICountry.h"

@interface BICountryTestCase : BITestCaseCoreData

@end

@implementation BICountryTestCase

#pragma mark - Test insertInManagedObjectContext: method

- (void)testInsertInManagedObjectContextSaveError {
    BICountry *country = [BICountry insertInManagedObjectContext:self.managedObjectContext];
    XCTAssert(country.uuid);
    
    NSDate *now = [NSDate date];
    NSComparisonResult createdAtResult = [now compare:country.createdat];
    NSComparisonResult updatedAtResult = [now compare:country.createdat];
    XCTAssert(createdAtResult == NSOrderedDescending);
    XCTAssert(updatedAtResult == NSOrderedDescending);
    
    NSError *error;
    [self.managedObjectContext save:&error];
    XCTAssert(error, @"Should not be able to save country without an name!");
}

- (void)testInsertInManagedObjectContextSaved {
    BICountry *country = [BICountry insertInManagedObjectContext:self.managedObjectContext];
    country.name = [NSString randomString];
    
    NSError *error;
    [self.managedObjectContext save:&error];
    XCTAssertFalse(error, @"Should be able to save context!");
}

#pragma mark - Test entityName method

- (void)testEntityName {
    NSString *entityName = [BICountry entityName];
    NSString *stringClass = NSStringFromClass([BICountry class]);
    XCTAssertEqualObjects(entityName, stringClass);
}

#pragma mark - Test entityInManagedObjectContext: method

- (void)testEntityInManagedObjectContextWithValidParam {
    NSString *entityName = [BICountry entityName];
    NSString *stringClass = NSStringFromClass([BICountry class]);
    
    NSEntityDescription *entity = [BICountry entityInManagedObjectContext:self.managedObjectContext];
    XCTAssertEqualObjects(entity.name, entityName);
    XCTAssertEqualObjects(entity.managedObjectClassName, stringClass);
    XCTAssertFalse(entity.isAbstract);
}

@end
