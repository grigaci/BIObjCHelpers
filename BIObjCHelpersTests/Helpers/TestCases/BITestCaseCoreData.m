//
//  BITestCaseCoreData.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/9/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BITestCaseCoreData.h"

@interface BITestCaseCoreData ()

@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistanceStoreCoordinator;

@end

@implementation BITestCaseCoreData

- (void)tearDown {
    _managedObjectContext = nil;
    [super tearDown];
}

#pragma mark - Property methods

- (NSManagedObjectModel *)managedObjectModel {
    if (!_managedObjectModel) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BIObjCHelpers" withExtension:@"momd"];
        NSAssert(modelURL, @"Invalid model url");
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistanceStoreCoordinator {
    if (!_persistanceStoreCoordinator) {
        _persistanceStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
#ifdef DEBUG
        NSPersistentStore * persistanceStore = [_persistanceStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:nil];
        NSAssert(persistanceStore, @"Cannot create persistance store in memory");
#endif
    }
    return _persistanceStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _managedObjectContext.persistentStoreCoordinator = self.persistanceStoreCoordinator;
    }
    return _managedObjectContext;
}

@end
