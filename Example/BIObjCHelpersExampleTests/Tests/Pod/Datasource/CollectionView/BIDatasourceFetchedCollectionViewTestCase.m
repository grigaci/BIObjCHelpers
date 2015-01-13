//
//  BIDatasourceFetchedCollectionViewTestCase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/13/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BITestCaseCoreData.h"
#import "BIMockDatasourceFetchedCollectionView.h"
#import "NSFetchedResultsController+BITestHelpers.h"

#import "BIDatasourceFetchedCollectionView.h"

@interface BIDatasourceFetchedCollectionViewTestCase : BITestCaseCoreData

@property (nonatomic, strong) BIDatasourceFetchedCollectionView *datasource;
@property (nonatomic, strong) BIMockDatasourceFetchedCollectionView *collectionView;

@end

@implementation BIDatasourceFetchedCollectionViewTestCase

- (void)setUp {
    [super setUp];
    UICollectionViewLayout *layout = [UICollectionViewFlowLayout new];
    self.collectionView = [[BIMockDatasourceFetchedCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.datasource = [BIDatasourceFetchedCollectionView datasourceWithCollectionView:self.collectionView];
}

- (void)tearDown {
    self.collectionView = nil;
    self.datasource = nil;
    [super tearDown];
}

#pragma mark - test init methods

- (void)testInitializer {
    XCTAssertThrows([BIDatasourceFetchedCollectionView datasourceWithCollectionView:nil]);
    XCTAssertEqual(self.collectionView.dataSource, self.datasource);
}

#pragma mark - Test collection view datasource methods

- (void)testCollectionViewDatasourceMethods {
    // Simulate an fetched with 1 section and 3 objects
    NSArray *objects = @[@1, @2, @3];
    NSFetchedResultsController *fetchedResults = [NSFetchedResultsController mockWithSectionsArray:@[objects]];
    self.datasource.fetchedResultsController = fetchedResults;

    XCTAssertEqual([self.datasource numberOfSectionsInCollectionView:self.collectionView], 1U);
    XCTAssertEqual([self.datasource collectionView:self.collectionView numberOfItemsInSection:0], objects.count);

    // Test the configure cell
    __block id testCell;
    __block NSIndexPath *testIndexPath;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];

    self.datasource.configureCellBlock = ^(id cell, NSIndexPath *indexPath){
        testIndexPath = indexPath;
        testCell = cell;
    };

    [self.datasource load];
    id returnedCell = [self.datasource collectionView:self.collectionView cellForItemAtIndexPath:indexPath];
    XCTAssertEqual(testCell, returnedCell);
    XCTAssertEqual(testIndexPath, indexPath);
}

- (void)testTableViewDatasourceMethodsWithoutSettingFetchedResults {
    XCTAssertThrows([self.datasource numberOfSectionsInCollectionView:self.collectionView]);
    XCTAssertThrows([self.datasource collectionView:self.collectionView numberOfItemsInSection:0]);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    XCTAssertThrows([self.datasource collectionView:self.collectionView cellForItemAtIndexPath:indexPath]);
}

#pragma mark - Test fetched results section changes

- (void)testAddSection {
    NSFetchedResultsController *fetchedResults = [NSFetchedResultsController new];
    NSUInteger sectionIndexToInsert = 1;
    NSIndexSet *sectionIndexSetToInsert = [NSIndexSet indexSetWithIndex:sectionIndexToInsert];
    self.datasource.fetchedResultsController = fetchedResults;

    __block NSIndexSet *testSections;
    self.collectionView.insertSectionsCallback = ^(NSIndexSet *sections) {
        testSections = sections;
    };

    [self.datasource controller:fetchedResults didChangeSection:nil atIndex:sectionIndexToInsert forChangeType:NSFetchedResultsChangeInsert];
    [self.datasource controllerDidChangeContent:fetchedResults];

    XCTAssert([testSections isEqualToIndexSet:sectionIndexSetToInsert]);
}

- (void)testDeleteSection {
    NSFetchedResultsController *fetchedResults = [NSFetchedResultsController new];
    NSUInteger sectionIndexToDeleted = 0;
    NSIndexSet *sectionIndexSetToDelete = [NSIndexSet indexSetWithIndex:sectionIndexToDeleted];
    self.datasource.fetchedResultsController = fetchedResults;
    
    __block NSIndexSet *testSections;
    self.collectionView.deleteSectionsCallback = ^(NSIndexSet *sections) {
        testSections = sections;
    };
    
    [self.datasource controller:fetchedResults didChangeSection:nil atIndex:sectionIndexToDeleted forChangeType:NSFetchedResultsChangeDelete];
    [self.datasource controllerDidChangeContent:fetchedResults];

    XCTAssert([testSections isEqualToIndexSet:sectionIndexSetToDelete]);
}

#pragma mark - Test fetched results item changes

- (void)testAddItems {
    NSFetchedResultsController *fetchedResults = [NSFetchedResultsController mockWithSectionsArray:@[@[@1, @2, @3]]];
    self.datasource.fetchedResultsController = fetchedResults;

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];

    __block NSArray *testItems;
    __block BOOL wasReloaded = NO;
    self.collectionView.insertItemsCallback = ^(NSArray *items) {
        testItems = items;
    };

    self.collectionView.reloadDataCallback = ^() {
        wasReloaded = YES;
    };

    [self.datasource controller:fetchedResults didChangeObject:nil atIndexPath:nil forChangeType:NSFetchedResultsChangeInsert newIndexPath:indexPath];
    [self.datasource controllerDidChangeContent:fetchedResults];

    if (!wasReloaded) {
        XCTAssert(testItems.count == 1);
        XCTAssertEqual(testItems[0], indexPath);
    } else {
        // Collection view was reloaded in order to prevent a known issue. No needed to test anything else.
        XCTAssert(true);
    }
}

- (void)testDeleteItems {
    NSFetchedResultsController *fetchedResults = [NSFetchedResultsController mockWithSectionsArray:@[@[@1, @2, @3]]];
    self.datasource.fetchedResultsController = fetchedResults;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    __block NSArray *testItems;
    __block BOOL wasReloaded = NO;
    self.collectionView.deleteItemsCallback = ^(NSArray *items) {
        testItems = items;
    };
    
    self.collectionView.reloadDataCallback = ^() {
        wasReloaded = YES;
    };
    
    [self.datasource controller:fetchedResults didChangeObject:nil atIndexPath:indexPath forChangeType:NSFetchedResultsChangeDelete newIndexPath:nil];
    [self.datasource controllerDidChangeContent:fetchedResults];
    
    if (!wasReloaded) {
        XCTAssert(testItems.count == 1);
        XCTAssertEqual(testItems[0], indexPath);
    } else {
        // Collection view was reloaded in order to prevent a known issue. No needed to test anything else.
        XCTAssert(true);
    }
}

- (void)testUpdateItems {
    NSFetchedResultsController *fetchedResults = [NSFetchedResultsController mockWithSectionsArray:@[@[@1]]];
    self.datasource.fetchedResultsController = fetchedResults;

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    __block NSArray *testItems;
    __block BOOL wasReloaded = NO;
    self.collectionView.reloadItemsCallback = ^(NSArray *items) {
        testItems = items;
    };
    
    self.collectionView.reloadDataCallback = ^() {
        wasReloaded = YES;
    };
    
    [self.datasource controller:fetchedResults didChangeObject:nil atIndexPath:indexPath forChangeType:NSFetchedResultsChangeUpdate newIndexPath:nil];
    [self.datasource controllerDidChangeContent:fetchedResults];

    if (!wasReloaded) {
        XCTAssert(testItems.count == 1);
        XCTAssertEqual(testItems[0], indexPath);
    } else {
        // Collection view was reloaded in order to prevent a known issue. No needed to test anything else.
        XCTAssert(true);
    }
}

- (void)testMoveItems {
    NSFetchedResultsController *fetchedResults = [NSFetchedResultsController mockWithSectionsArray:@[@[@1]]];
    self.datasource.fetchedResultsController = fetchedResults;
    
    NSIndexPath *from = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *to = [NSIndexPath indexPathForRow:1 inSection:0];
    
    __block NSIndexPath *testFrom;
    __block NSIndexPath *testTo;
    __block BOOL wasReloaded = NO;
    self.collectionView.moveItemCallback = ^(NSIndexPath *aFrom, NSIndexPath *aTo) {
        testFrom = aFrom;
        testTo = aTo;
    };

    self.collectionView.reloadDataCallback = ^() {
        wasReloaded = YES;
    };
    
    [self.datasource controller:fetchedResults didChangeObject:nil atIndexPath:from forChangeType:NSFetchedResultsChangeMove newIndexPath:to];
    [self.datasource controllerDidChangeContent:fetchedResults];
    
    if (!wasReloaded) {
        XCTAssertEqual(testFrom, from);
        XCTAssertEqual(testTo, to);
    } else {
        // Collection view was reloaded in order to prevent a known issue. No needed to test anything else.
        XCTAssert(true);
    }
}

#pragma mark - Test load method

- (void)testLoadWithInvalidValues {
    self.datasource.cellIdentifier = @"";
    XCTAssertThrows([self.datasource load]);

    self.datasource.cellClass = [NSString class];
    XCTAssertThrows([self.datasource load]);
}

#pragma mark - Property

- (void)testDefaultPropertyValues {
    XCTAssertEqual(self.datasource.cellClass, [UICollectionViewCell class]);
    XCTAssert(self.datasource.cellIdentifier.length);
}

- (void)testCellIdentifierUniqueness {
    // Cell identifier should be unique.
    BIDatasourceFetchedCollectionView *anotherDatasource = [BIDatasourceFetchedCollectionView datasourceWithCollectionView:self.collectionView];
    XCTAssertNotEqual(self.datasource.cellIdentifier, anotherDatasource.cellIdentifier);
}

@end
