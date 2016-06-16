//
//  MockNSFetchedResultsController.h
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 6/16/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface MockNSFetchedResultsController : NSFetchedResultsController

- (nonnull instancetype)initWithObjects:(nonnull NSArray *)objects;

@property (nonatomic, strong, nullable, readwrite) NSArray *fetchedObjects;
@property (nonatomic, strong, nullable, readwrite) NSArray<id<NSFetchedResultsSectionInfo>> *sections;

@end
