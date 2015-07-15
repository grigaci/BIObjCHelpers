//
//  BIAllCountriesDatasource.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/16/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIAllCountriesDatasource.h"
#import "BICountry.h"

#import <MagicalRecord/MagicalRecord.h>

@implementation BIAllCountriesDatasource

#pragma mark - BIDatasourceFetchedTableView methods

- (void)load {
    NSParameterAssert(self.managedObjectContext);
    self.fetchedResultsController = [BICountry MR_fetchAllGroupedBy:nil withPredicate:nil sortedBy:BICountryAttributes.name ascending:YES delegate:nil inContext:self.managedObjectContext];
    [super load];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    BICountry *country = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = country.name;
}

@end
