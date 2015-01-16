//
//  BIAppStarterPopulateCoreData.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/13/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import <MagicalRecord/CoreData+MagicalRecord.h>

#import "BIAppStarterPopulateCoreData.h"
#import "BICountry.h"
#import "BICapital.h"

const struct BIAppStarterPopulateCoreDataPlistKeys BIAppStarterPopulateCoreDataPlistKeys = {
    .country = @"country",
    .capital = @"capital",
};

@implementation BIAppStarterPopulateCoreData

#pragma mark - Constants

NSString * const kDefaultDataFileName = @"DefaultData.plist";

#pragma mark - BIStarter methods

- (void)start {
    if ([self isDatabaseEmpty]) {
        [self loadFromPList];
        [self.managedObjectContext MR_saveToPersistentStoreAndWait];
    }
}

#pragma mark - Property methods

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [NSManagedObjectContext MR_defaultContext];
    }
    return _managedObjectContext;
}

#pragma mark - Private

- (BOOL)isDatabaseEmpty {
    BICountry *anyCountry = [BICountry MR_findFirstInContext:self.managedObjectContext];
    return anyCountry == nil;
}

- (void)loadFromPList {
    NSParameterAssert(self.managedObjectContext);

    NSString *filename = [kDefaultDataFileName stringByDeletingPathExtension];
    NSString *extension = [kDefaultDataFileName pathExtension];
    NSString *fullFilepath = [[NSBundle mainBundle] pathForResource:filename ofType:extension];
    NSParameterAssert(fullFilepath.length);

    NSArray *allItems = [NSArray arrayWithContentsOfFile:fullFilepath];
    for (NSDictionary *itemDict in allItems) {
        BICountry *country = [BICountry insertInManagedObjectContext:self.managedObjectContext];
        country.name = itemDict[BIAppStarterPopulateCoreDataPlistKeys.country];;
        
        BICapital *capital = [BICapital insertInManagedObjectContext:self.managedObjectContext];
        capital.name = itemDict[BIAppStarterPopulateCoreDataPlistKeys.capital];
        
        country.capital = capital;
    }
}

@end
