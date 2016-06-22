//
//  BIDatasourceFetchedTableViewTestCase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/12/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BITestCaseCoreData.h"
#import "MockNSFetchedResultsController.h"
#import "MockNSFetchedResultsSectionInfo.h"
#import "MockBITableView.h"

#import "BIDatasourceFetchedTableView.h"

@interface BIDatasourceFetchedTableViewTestCase : BITestCaseCoreData

@property (nonatomic, strong) BIDatasourceFetchedTableView *datasource;
@property (nonatomic, strong) MockBITableView *tableView;

@end

@implementation BIDatasourceFetchedTableViewTestCase

- (void)setUp {
    [super setUp];
    self.tableView = [[MockBITableView alloc] initWithFrame:CGRectZero];
    self.datasource = [BIDatasourceFetchedTableView datasourceWithTableView:self.tableView];
    self.datasource.cellClass = [UITableViewCell class];
}

- (void)tearDown {
    self.datasource = nil;
    self.tableView = nil;
    [super tearDown];
}

#pragma mark - Init methods

- (void)testInitializer {
    XCTAssertEqual(self.tableView.dataSource, self.datasource);
}

#pragma mark - TableView datasource methods

- (void)testTableViewDatasourceMethods {
    // Simulate an fetched with 1 section and 2 objects
    NSArray *objects = @[@1, @2];
    MockNSFetchedResultsController *fetchedResults = [[MockNSFetchedResultsController alloc] initWithObjects:objects];
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
    __block NSIndexSet *returnedSections;
    self.tableView.insertSectionsWithRowAnimationCallback = ^(NSIndexSet * __nonnull sections, UITableViewRowAnimation animation) {
        returnedSections = sections;
    };
    self.datasource = [BIDatasourceFetchedTableView datasourceWithTableView:self.tableView];
    MockNSFetchedResultsController *fetchedResults = [[MockNSFetchedResultsController alloc] initWithObjects:@[]];
    NSUInteger sectionIndexToInsert = 1;
    MockNSFetchedResultsSectionInfo *sectionInfo = [MockNSFetchedResultsSectionInfo new];
    [self.datasource controller:fetchedResults didChangeSection:sectionInfo atIndex:sectionIndexToInsert forChangeType:NSFetchedResultsChangeInsert];

    XCTAssertNotNil(returnedSections);
}

- (void)testSectionDeleted {
    __block NSIndexSet *returnedSections;
    self.tableView.deleteSectionsWithRowAnimationCallback = ^(NSIndexSet * __nonnull sections, UITableViewRowAnimation animation) {
        returnedSections = sections;
    };

    self.datasource = [BIDatasourceFetchedTableView datasourceWithTableView:self.tableView];
        MockNSFetchedResultsController *fetchedResults = [[MockNSFetchedResultsController alloc] initWithObjects:@[]];
    NSUInteger sectionIndexToDelete = 0;
    MockNSFetchedResultsSectionInfo *sectionInfo = [MockNSFetchedResultsSectionInfo new];
    [self.datasource controller:fetchedResults didChangeSection:sectionInfo atIndex:sectionIndexToDelete forChangeType:NSFetchedResultsChangeDelete];
    
    XCTAssertNotNil(returnedSections);
}

#pragma mark - Test fetched results section changes

- (void)testNewObjectAdded {
    __block NSArray *returnedIndexPaths;
    self.tableView.insertRowsAtIndexPathsWithRowAnimationCallback = ^(NSArray * __nonnull indexPaths, UITableViewRowAnimation animation) {
        returnedIndexPaths = indexPaths;
    };
    self.datasource = [BIDatasourceFetchedTableView datasourceWithTableView:self.tableView];
    MockNSFetchedResultsController *fetchedResults = [[MockNSFetchedResultsController alloc] initWithObjects:@[]];
    self.datasource.fetchedResultsController = fetchedResults;
    NSIndexPath *newRow = [NSIndexPath indexPathForRow:1 inSection:1];
    MockNSFetchedResultsSectionInfo *sectionInfo = [MockNSFetchedResultsSectionInfo new];
    [self.datasource controller:fetchedResults didChangeObject:sectionInfo atIndexPath:nil forChangeType:NSFetchedResultsChangeInsert newIndexPath:newRow];
    
    XCTAssertNotNil(returnedIndexPaths);
}

- (void)testObjectDeleted {
    __block NSArray *returnedIndexPaths;
    self.tableView.deleteRowsAtIndexPathsWithRowAnimationCallback = ^(NSArray * __nonnull indexPaths, UITableViewRowAnimation animation) {
        returnedIndexPaths = indexPaths;
    };
    self.datasource = [BIDatasourceFetchedTableView datasourceWithTableView:self.tableView];
    MockNSFetchedResultsController *fetchedResults = [[MockNSFetchedResultsController alloc] initWithObjects:@[]];
    self.datasource.fetchedResultsController = fetchedResults;
    NSIndexPath *deletedRow = [NSIndexPath indexPathForRow:1 inSection:1];
    MockNSFetchedResultsSectionInfo *sectionInfo = [MockNSFetchedResultsSectionInfo new];
    [self.datasource controller:fetchedResults didChangeObject:sectionInfo atIndexPath:deletedRow forChangeType:NSFetchedResultsChangeDelete newIndexPath:nil];
    
    XCTAssertNotNil(returnedIndexPaths);
}

- (void)testObjectUpdate {
    self.datasource = [BIDatasourceFetchedTableView datasourceWithTableView:self.tableView];
    NSFetchedResultsController *fetchedResults = [NSFetchedResultsController new];
    self.datasource.fetchedResultsController = fetchedResults;
    NSIndexPath *updateIndexPath = [NSIndexPath indexPathForRow:1 inSection:1];

    [self.datasource load];
    __block NSIndexPath *testIndexPath;
    self.datasource.configureCellBlock = ^(id cell, NSIndexPath *indexPath) {
        testIndexPath = indexPath;
    };

    MockNSFetchedResultsSectionInfo *sectionInfo = [MockNSFetchedResultsSectionInfo new];
    [self.datasource controller:fetchedResults didChangeObject:sectionInfo atIndexPath:updateIndexPath forChangeType:NSFetchedResultsChangeUpdate newIndexPath:nil];
    XCTAssertEqual(testIndexPath, updateIndexPath);
}

- (void)testObjectMoved {
    __block NSArray *returnedIndexPaths;
    self.tableView.deleteRowsAtIndexPathsWithRowAnimationCallback = ^(NSArray * __nonnull indexPaths, UITableViewRowAnimation animation) {
        returnedIndexPaths = indexPaths;
    };

    self.datasource = [BIDatasourceFetchedTableView datasourceWithTableView:self.tableView];
    MockNSFetchedResultsController *fetchedResults = [[MockNSFetchedResultsController alloc] initWithObjects:@[]];
    self.datasource.fetchedResultsController = fetchedResults;
    NSIndexPath *fromIndexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:1 inSection:2];
    MockNSFetchedResultsSectionInfo *sectionInfo = [MockNSFetchedResultsSectionInfo new];
    [self.datasource controller:fetchedResults didChangeObject:sectionInfo atIndexPath:fromIndexPath forChangeType:NSFetchedResultsChangeMove newIndexPath:toIndexPath];

    XCTAssertNotNil(returnedIndexPaths);
}

#pragma mark - Property

- (void)testDefaultPropertyValues {
    XCTAssertEqualObjects(self.datasource.cellClass, [UITableViewCell class]);
    XCTAssert(self.datasource.cellIdentifier.length);
}

- (void)testCellIdentifierUniqueness {
    // Cell identifier should be unique.
    BIDatasourceFetchedTableView *anotherDatasource = [BIDatasourceFetchedTableView datasourceWithTableView:self.tableView];
    XCTAssertNotEqual(self.datasource.cellIdentifier, anotherDatasource.cellIdentifier);
}

#pragma mark - Test adopted protocols

- (void)testProtocolFetchedResultsControllerDelegate {
    XCTAssert([self.datasource conformsToProtocol:@protocol(NSFetchedResultsControllerDelegate)]);
    
    NSFetchedResultsController *fetchedResults = [[self class] fetchedResultsDelegate];
    self.datasource.fetchedResultsController = fetchedResults;
    XCTAssertEqual(fetchedResults.delegate, self.datasource);
    
    // Test setting to nil the delegate of previous fetched results controller
    NSFetchedResultsController *fetchedResults2 = [[self class] fetchedResultsDelegate];
    self.datasource.fetchedResultsController = fetchedResults2;
    XCTAssertFalse(fetchedResults.delegate, @"Previous fetched results should be nil");
}

#pragma mark - Test fetchedResultsController property

- (void)testFetchedResultsControllerDefault {
    XCTAssertFalse(self.datasource.fetchedResultsController, @"Property should not be set by default");
    XCTAssertThrows(self.datasource.fetchedResultsController = nil, @"Should not accept nil");
    
    // Testing the custom setter
    NSFetchedResultsController *fetchedResults = [[self class] fetchedResultsDelegate];
    self.datasource.fetchedResultsController = fetchedResults;
    XCTAssertEqual(fetchedResults, self.datasource.fetchedResultsController);
}

#pragma mark - Test paused property

- (void)testPausedDefault {
    XCTAssertFalse(self.datasource.isPaused, @"Default value should be NO!");
    NSFetchedResultsController *fetchedResults = [[self class] fetchedResultsDelegate];
    self.datasource.fetchedResultsController = fetchedResults;
    
    // Testing the custom setter
    self.datasource.paused = YES;
    XCTAssert(self.datasource.isPaused);
    // Should verify that the fetched was performed here
}

#pragma mark - Factory methods

+ (NSFetchedResultsController *)fetchedResultsDelegate {
    NSFetchedResultsController *fetchedResults = [NSFetchedResultsController new];
    return fetchedResults;
}

@end
