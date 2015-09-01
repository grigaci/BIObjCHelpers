//
//  BIDatasourceFeedTableViewTestCase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 14/07/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIBatch.h"
#import "BITableView.h"
#import "BITableViewCell.h"
#import "BIMockDatasourceFeedTableView.h"

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface BIDatasourceFeedTableViewTestCase : XCTestCase

@property (nonatomic, strong, nullable) BITableView *tableView;
@property (nonatomic, strong, nullable) BIMockDatasourceFeedTableView *datasource;

@end

@implementation BIDatasourceFeedTableViewTestCase

- (void)setUp {
    [super setUp];
    self.tableView = [[BITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.datasource = [BIMockDatasourceFeedTableView datasourceWithBITableView:self.tableView];
    [self.datasource load];
}

- (void)tearDown {
    self.tableView = nil;
    self.datasource = nil;
    [super tearDown];
}

#pragma mark - Test createNextBatch

- (void)testCreateNextBatchCallback {
    __block BOOL wasCalled = NO;
    __block BIBatch *batch;
    self.datasource.createNextBatchCallback = ^() {
        wasCalled = YES;
        batch = [[BIBatch alloc] initWithCompletionBlock:nil];
        return batch;
    };
    [self.tableView triggerInfiniteScrolling];
    XCTAssertTrue(wasCalled);
    XCTAssertEqual(batch, self.datasource.currentBatch);
}

#pragma mark - Test fetchBatch

- (void)testFetchBatch {
    __block BOOL wasCalled = NO;
    self.datasource.fetchBatchCallback = ^(BIBatch * __nonnull batch) {
        wasCalled = YES;
    };
    [self.tableView triggerInfiniteScrolling];
    XCTAssertTrue(wasCalled);
    XCTAssertEqual(self.tableView.infiniteScrollingState, BIInfiniteScrollingStateLoading);
}

#pragma mark - Test fetchBatchCompletedWithFailure

- (void)testFetchBatchCompletedWithFailure {
    __block NSError *returnedError = nil;
    NSError *sentError = [[NSError alloc] init];
    self.datasource.fetchBatchCompletedWithFailureCallback = ^(NSError * __nonnull error) {
        returnedError = error;
    };
    [self.tableView triggerInfiniteScrolling];
    self.datasource.currentBatch.completionBlock(sentError, nil);
    XCTAssertEqual(sentError, returnedError);
}

#pragma mark - Test fetchBatchCompletedWithSuccess

- (void)testFetchBatchCompletedWithSuccess {
    __block NSArray *returnedItems = nil;
    NSArray *sentItems = @[];
    self.datasource.fetchBatchCompletedWithSuccessCallback = ^(NSArray * __nonnull items) {
        returnedItems = items;
    };
    [self.tableView triggerInfiniteScrolling];
    self.datasource.currentBatch.completionBlock(nil, sentItems);
    XCTAssertEqual(sentItems, returnedItems);
}

#pragma mark - Test fetchBatchCompletedCommon

- (void)testFetchBatchCompletedCommon {
    [self.tableView triggerInfiniteScrolling];
    [self.datasource fetchBatchCompletedCommon];
    XCTAssertEqual(self.tableView.infiniteScrollingState, BIInfiniteScrollingStateStopped);
    XCTAssertNil(self.datasource.currentBatch);
}

#pragma mark - Test load

- (void)testLoad {
    XCTAssertEqualObjects(self.datasource.cellClass, [BITableViewCell class]);
    XCTAssert(self.datasource.cellIdentifier.length);
}

@end
