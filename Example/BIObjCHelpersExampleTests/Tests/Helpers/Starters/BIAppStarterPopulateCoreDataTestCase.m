//
//  BIAppStarterPopulateCoreDataTestCase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/13/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BITestCaseCoreData.h"

#import "BIAppStarterPopulateCoreData.h"
#import "BICountry.h"
#import "BICapital.h"

#import <MagicalRecord/MagicalRecord.h>

@interface BIAppStarterPopulateCoreDataTestCase : BITestCaseCoreData

@property (nonatomic, strong) BIAppStarterPopulateCoreData *starter;

@end

@implementation BIAppStarterPopulateCoreDataTestCase

#pragma mark - Constants

NSString * const kDefaultDataFileName = @"DefaultData.plist";

#pragma mark - Setup methods

- (void)setUp {
    [super setUp];
    self.starter = [BIAppStarterPopulateCoreData new];
    self.starter.managedObjectContext = self.managedObjectContext;
    [self.starter start];
}

- (void)tearDown {
    self.starter = nil;
    [super tearDown];
}

#pragma mark - Test number of objects

- (void)testCountObject {
    NSString *filename = [kDefaultDataFileName stringByDeletingPathExtension];
    NSString *extension = [kDefaultDataFileName pathExtension];
    NSString *fullFilepath = [[NSBundle mainBundle] pathForResource:filename ofType:extension];
    
    NSArray *allItems = [NSArray arrayWithContentsOfFile:fullFilepath];
    NSArray *allCountries = [BICountry MR_findAllInContext:self.managedObjectContext];
    NSArray *allCapitals = [BICapital MR_findAllInContext:self.managedObjectContext];
    
    XCTAssertEqual(allCapitals.count, allItems.count);
    XCTAssertEqual(allCountries.count, allItems.count);
    XCTAssertFalse([self.managedObjectContext hasChanges], @"Starter should save the changes from managed object context");
}

@end
