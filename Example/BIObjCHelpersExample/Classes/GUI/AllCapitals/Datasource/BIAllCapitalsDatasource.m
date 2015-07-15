//
//  BIAllCapitalsDatasource.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/16/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIAllCapitalsDatasource.h"
#import "BIAllCapitalsCollectionViewCell.h"
#import "BICapital.h"

#import <MagicalRecord/MagicalRecord.h>


@implementation BIAllCapitalsDatasource

#pragma mark - BIDatasourceFetchedCollectionView methods

- (void)load {
    NSParameterAssert(self.managedObjectContext);
    self.fetchedResultsController = [BICapital MR_fetchAllGroupedBy:nil withPredicate:nil sortedBy:BICapitalAttributes.name ascending:YES delegate:nil inContext:self.managedObjectContext];
    self.cellIdentifier = NSStringFromClass([BIAllCapitalsCollectionViewCell class]);
    self.cellClass = [BIAllCapitalsCollectionViewCell class];
    [super load];
}

- (void)configureCell:(BIAllCapitalsCollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    BICapital *capital = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.label.text = capital.name;
}

@end
