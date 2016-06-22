//
//  MockNSFetchedResultsController.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 6/16/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import "MockNSFetchedResultsController.h"
#import "MockNSFetchedResultsSectionInfo.h"
#import "NSString+RandomTest.h"

@implementation MockNSFetchedResultsController

@synthesize fetchedObjects;
@synthesize sections;

#pragma mark - Init methods

- (nonnull instancetype)initWithObjects:(nonnull NSArray *)objects {
    self = [super init];
    if (self) {
        MockNSFetchedResultsSectionInfo *firstSection = [MockNSFetchedResultsSectionInfo new];
        firstSection.name = [NSString randomString];
        firstSection.numberOfObjects = objects.count;
        firstSection.objects = objects;
        self.sections = @[firstSection];
        self.fetchedObjects = objects;
    }
    return self;
}

@end
