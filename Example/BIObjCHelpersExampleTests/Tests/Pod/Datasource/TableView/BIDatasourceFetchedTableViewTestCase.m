//
//  BIDatasourceFetchedTableViewTestCase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/12/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

@import XCTest;
@import Foundation;

#define HC_SHORTHAND
#define MOCKITO_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/OCMockito.h>

#import "BITestCaseCoreData.h"
#import "NSFetchedResultsController+BITestHelpers.h"

#import "BIDatasourceFetchedTableView.h"

@interface BIDatasourceFetchedTableViewTestCase : BITestCaseCoreData

@property (nonatomic, strong) BIDatasourceFetchedTableView *datasource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BIDatasourceFetchedTableViewTestCase

- (void)setUp {
    [super setUp];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.datasource = [BIDatasourceFetchedTableView datasourceWithTableView:self.tableView];
}

- (void)tearDown {
    self.datasource = nil;
    self.tableView = nil;
    [super tearDown];
}

#pragma mark - Init methods

- (void)testInitializer {
    XCTAssertThrows([BIDatasourceFetchedTableView datasourceWithTableView:nil]);
    XCTAssertEqual(self.tableView.dataSource, self.datasource);
}

#pragma mark - TableView datasource methods

- (void)testTableViewDatasourceMethods {
    // Simulate an fetched with 1 section and 2 objects
    NSArray *objects = @[@1, @2];
    NSFetchedResultsController *fetchedResults = [NSFetchedResultsController mockWithSectionsArray:@[objects]];
    self.datasource.fetchedResultsController = fetchedResults;

    XCTAssertEqual([self.datasource numberOfSectionsInTableView:self.tableView], 1U);
    XCTAssertEqual([self.datasource tableView:self.tableView numberOfRowsInSection:0], objects.count);
    
    // Test the configure cell
    __block id testCell;
    __block NSIndexPath *testIndexPath;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];

    self.datasource.configureCellBlock = ^(id cell, NSIndexPath *indexPath){
        testIndexPath = indexPath;
        testCell = cell;
    };

    [self.datasource load];
    id returnedCell = [self.datasource tableView:self.tableView cellForRowAtIndexPath:indexPath];
    XCTAssertEqual(testCell, returnedCell);
    XCTAssertEqual(testIndexPath, indexPath);
}

- (void)testTableViewDatasourceMethodsWithoutSettingFetchedResults {
    XCTAssertThrows([self.datasource numberOfSectionsInTableView:self.tableView]);
    XCTAssertThrows([self.datasource tableView:self.tableView numberOfRowsInSection:0]);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    XCTAssertThrows([self.datasource tableView:self.tableView cellForRowAtIndexPath:indexPath]);
}

#pragma mark - Test fetched results section changes

- (void)testNewSectionAdded {
    self.tableView = mock([UITableView class]);
    self.datasource = [BIDatasourceFetchedTableView datasourceWithTableView:self.tableView];
    NSFetchedResultsController *fetchedResults = [NSFetchedResultsController new];
    NSUInteger sectionIndexToInsert = 1;
    NSIndexSet *sectionIndexSetToInsert = [NSIndexSet indexSetWithIndex:sectionIndexToInsert];
    [self.datasource controller:fetchedResults didChangeSection:nil atIndex:sectionIndexToInsert forChangeType:NSFetchedResultsChangeInsert];

    id verifyCountObj = verifyCount(self.tableView, times(1));
    verifyCountObj = [verifyCountObj withMatcher:anything() forArgument:1]; // ignore withRowAnimation param
    verifyCountObj = [verifyCountObj withMatcher:equalTo(sectionIndexSetToInsert) forArgument:0]; // validate the section index sent to tableview
    [verifyCountObj insertSections:anything() withRowAnimation:UITableViewRowAnimationBottom];
}

- (void)testSectionDeleted {
    self.tableView = mock([UITableView class]);
    self.datasource = [BIDatasourceFetchedTableView datasourceWithTableView:self.tableView];
    NSFetchedResultsController *fetchedResults = [NSFetchedResultsController new];
    NSUInteger sectionIndexToDelete = 0;
    NSIndexSet *sectionIndexSetToDelete = [NSIndexSet indexSetWithIndex:sectionIndexToDelete];
    [self.datasource controller:fetchedResults didChangeSection:nil atIndex:sectionIndexToDelete forChangeType:NSFetchedResultsChangeDelete];
    
    id verifyCountObj = verifyCount(self.tableView, times(1));
    verifyCountObj = [verifyCountObj withMatcher:anything() forArgument:1]; // ignore withRowAnimation param
    verifyCountObj = [verifyCountObj withMatcher:equalTo(sectionIndexSetToDelete) forArgument:0]; // validate the section index sent to tableview
    [verifyCountObj deleteSections:anything() withRowAnimation:UITableViewRowAnimationBottom];
}

#pragma mark - Test fetched results section changes

- (void)testNewObjectAdded {
    self.tableView = mock([UITableView class]);
    self.datasource = [BIDatasourceFetchedTableView datasourceWithTableView:self.tableView];
    NSFetchedResultsController *fetchedResults = [NSFetchedResultsController new];
    NSIndexPath *newRow = [NSIndexPath indexPathForRow:1 inSection:1];
    [self.datasource controller:fetchedResults didChangeObject:nil atIndexPath:nil forChangeType:NSFetchedResultsChangeInsert newIndexPath:newRow];
    
    id verifyCountObj = verifyCount(self.tableView, times(1));
    verifyCountObj = [verifyCountObj withMatcher:anything() forArgument:1]; // ignore withRowAnimation param
    verifyCountObj = [verifyCountObj withMatcher:equalTo(@[newRow]) forArgument:0]; // validate the object index sent to tableview
    [verifyCountObj insertRowsAtIndexPaths:anything() withRowAnimation:UITableViewRowAnimationBottom];
}

- (void)testObjectDeleted {
    self.tableView = mock([UITableView class]);
    self.datasource = [BIDatasourceFetchedTableView datasourceWithTableView:self.tableView];
    NSFetchedResultsController *fetchedResults = [NSFetchedResultsController new];
    NSIndexPath *deletedRow = [NSIndexPath indexPathForRow:1 inSection:1];
    [self.datasource controller:fetchedResults didChangeObject:nil atIndexPath:deletedRow forChangeType:NSFetchedResultsChangeDelete newIndexPath:nil];
    
    id verifyCountObj = verifyCount(self.tableView, times(1));
    verifyCountObj = [verifyCountObj withMatcher:anything() forArgument:1]; // ignore withRowAnimation param
    verifyCountObj = [verifyCountObj withMatcher:equalTo(@[deletedRow]) forArgument:0]; // validate the object index sent to tableview
    [verifyCountObj deleteRowsAtIndexPaths:anything() withRowAnimation:UITableViewRowAnimationBottom];
}

- (void)testObjectUpdate {
    self.tableView = mock([UITableView class]);
    self.datasource = [BIDatasourceFetchedTableView datasourceWithTableView:self.tableView];
    NSFetchedResultsController *fetchedResults = [NSFetchedResultsController new];
    self.datasource.fetchedResultsController = fetchedResults;
    NSIndexPath *updateIndexPath = [NSIndexPath indexPathForRow:1 inSection:1];

    [self.datasource load];
    __block NSIndexPath *testIndexPath;
    self.datasource.configureCellBlock = ^(id cell, NSIndexPath *indexPath) {
        testIndexPath = indexPath;
    };

    [self.datasource controller:fetchedResults didChangeObject:nil atIndexPath:updateIndexPath forChangeType:NSFetchedResultsChangeUpdate newIndexPath:nil];
    XCTAssertEqual(testIndexPath, updateIndexPath);
}

- (void)testObjectMoved {
    self.tableView = mock([UITableView class]);
    self.datasource = [BIDatasourceFetchedTableView datasourceWithTableView:self.tableView];
    NSFetchedResultsController *fetchedResults = [NSFetchedResultsController new];
    NSIndexPath *fromIndexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:1 inSection:2];
    [self.datasource controller:fetchedResults didChangeObject:nil atIndexPath:fromIndexPath forChangeType:NSFetchedResultsChangeMove newIndexPath:toIndexPath];

    // Test the delete call
    id verifyCountObj = verifyCount(self.tableView, times(1));
    verifyCountObj = [verifyCountObj withMatcher:anything() forArgument:1]; // ignore withRowAnimation param
    verifyCountObj = [verifyCountObj withMatcher:equalTo(@[fromIndexPath]) forArgument:0]; // validate the delete index sent to tableview
    [verifyCountObj deleteRowsAtIndexPaths:anything() withRowAnimation:UITableViewRowAnimationBottom];
    
    // Test the insert call
    verifyCountObj = verifyCount(self.tableView, times(1));
    verifyCountObj = [verifyCountObj withMatcher:anything() forArgument:1]; // ignore withRowAnimation param
    verifyCountObj = [verifyCountObj withMatcher:equalTo(@[fromIndexPath]) forArgument:0]; // validate the insert index sent to tableview
    [verifyCountObj deleteRowsAtIndexPaths:anything() withRowAnimation:UITableViewRowAnimationBottom];
}

#pragma mark - Property

- (void)testDefaultPropertyValues {
    XCTAssertEqual(self.datasource.cellClass, [UITableViewCell class]);
    XCTAssert(self.datasource.cellIdentifier.length);
}

- (void)testCellIdentifierUniqueness {
    // Cell identifier should be unique.
    BIDatasourceFetchedTableView *anotherDatasource = [BIDatasourceFetchedTableView datasourceWithTableView:self.tableView];
    XCTAssertNotEqual(self.datasource.cellIdentifier, anotherDatasource.cellIdentifier);
}

@end
