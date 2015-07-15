//
//  NSFetchedResultsController+BITestHelpers.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/13/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "NSFetchedResultsController+BITestHelpers.h"

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>


@implementation NSFetchedResultsController (BITestHelpers)

+ (instancetype)mockWithSectionsArray:(NSArray *)sectionsData {
    NSParameterAssert(sectionsData.count);
    NSMutableArray *fetchedSections = [NSMutableArray new];

    for (NSArray *objects in sectionsData) {
        id <NSFetchedResultsSectionInfo> sectionInfo = mockProtocol(@protocol(NSFetchedResultsSectionInfo));
        [given([sectionInfo objects]) willReturn:objects];
        [given([sectionInfo numberOfObjects]) willReturn:@(objects.count)];
        [fetchedSections addObject:sectionInfo];
    }

    NSFetchedResultsController *fetchedResults = mock([NSFetchedResultsController class]);
    [given([fetchedResults sections]) willReturn:fetchedSections];
    return fetchedResults;
}

@end
