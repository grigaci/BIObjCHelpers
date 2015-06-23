//
//  NSFetchedResultsController+BITestHelpers.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/13/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSFetchedResultsController (BITestHelpers)

+ (instancetype)mockWithSectionsArray:(NSArray *)sections;

@end
