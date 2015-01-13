//
//  BIDatasourceFetchedResultsBaseTestCase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/12/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BITestCaseCoreData.h"

#import "BIDatasourceFetchedResultsBase.h"

@interface BIDatasourceFetchedResultsBaseTestCase : BITestCaseCoreData

@property (nonatomic,  strong) BIDatasourceFetchedResultsBase *datasource;

@end

@implementation BIDatasourceFetchedResultsBaseTestCase

- (void)setUp {
    [super setUp];
    self.datasource = [BIDatasourceFetchedResultsBase new];
}

- (void)tearDown {
    self.datasource = nil;
    [super tearDown];
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
