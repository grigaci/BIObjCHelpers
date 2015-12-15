//
//  BIDatasourceFeedTableViewTestCase.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 14/07/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIBatchRequest.h"
#import "BIBatchResponse.h"
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

#pragma mark - Test Inits

- (void)test_inits {
    BIDatasourceFeedTableView *datasource = [BIMockDatasourceFeedTableView datasourceWithBITableView:self.tableView];
    XCTAssertNotNil(datasource);
    datasource = [[BIMockDatasourceFeedTableView alloc] initWithBITableView:self.tableView];
    XCTAssertNotNil(datasource);
    XCTAssertEqual(datasource.tableView, self.tableView);
}

#pragma mark - Test createNextBatch

- (void)testCreateNextBatchCallback {
    __block BOOL wasCalled = NO;
    __block BIBatchRequest *batchRequest;
    self.datasource.createNextBatchCallback = ^() {
        wasCalled = YES;
        batchRequest = [[BIBatchRequest alloc] initWithCompletionBlock:nil];
        return batchRequest;
    };
    [self.tableView triggerInfiniteScrolling];
    XCTAssertTrue(wasCalled);
}

#pragma mark - Test fetchBatch

- (void)testFetchBatch {
    __block BOOL wasCalled = NO;
    self.datasource.fetchBatchCallback = ^(BIBatchRequest * __nonnull batch) {
        wasCalled = YES;
    };
    [self.tableView triggerInfiniteScrolling];
    XCTAssertTrue(wasCalled);
    XCTAssertEqual(self.tableView.infiniteScrollingState, BIInfiniteScrollingStateLoading);
}

#pragma mark - Test fetchBatchCompletedWithFailure

- (void)testFetchBatchCompletedWithFailure {
    __block NSError *returnedError = nil;
    NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:nil];
    BIBatchRequest *batchRequest = [[BIBatchRequest alloc] initWithCompletionBlock:nil];
    BIMutableBatchResponse *batchResponse = [[BIMutableBatchResponse alloc] initWithBatchRequest:batchRequest];
    batchResponse.error = error;
    self.datasource.handleFetchBatchResponseWithFailureCallback = ^(BIBatchResponse * __nonnull aBatchResponse) {
        returnedError = aBatchResponse.error;
    };
    [self.tableView triggerInfiniteScrolling];
    self.datasource.currentBatchRequest.completionBlock(batchResponse);
    XCTAssertEqual(returnedError, error);
}

#pragma mark - Test fetchBatchCompletedWithSuccess

- (void)testFetchBatchCompletedWithSuccess {
    __block NSArray *returnedItems = nil;
    NSArray *sentItems = @[];
    BIBatchRequest *batchRequest = [[BIBatchRequest alloc] initWithCompletionBlock:nil];
    BIMutableBatchResponse *batchResponse = [[BIMutableBatchResponse alloc] initWithBatchRequest:batchRequest];
    batchResponse.indexPaths = sentItems;
    self.datasource.handleFetchBatchResponseWithSuccessCallback = ^(BIBatchResponse * __nonnull aBatchResponse) {
        returnedItems = aBatchResponse.indexPaths;
    };
    [self.tableView triggerInfiniteScrolling];
    self.datasource.currentBatchRequest.completionBlock(batchResponse);
    XCTAssertEqual(sentItems, returnedItems);
}

#pragma mark - Test fetchBatchCompletedCommon

- (void)testFetchBatchCompletedCommonInsertTop {
    BIBatchRequest *batchRequest = [[BIBatchRequest alloc] initWithCompletionBlock:nil];
    batchRequest.insertPosition = BIBatchInsertPositionTop;
    BIMutableBatchResponse *batchResponse = [[BIMutableBatchResponse alloc] initWithBatchRequest:batchRequest];

    [self.tableView triggerInfiniteScrolling];
    [self.tableView triggerPullToRefresh];
    [self.datasource handleFetchBatchResponseCommon:batchResponse];
    XCTAssertEqual(self.tableView.infiniteScrollingState, BIInfiniteScrollingStateLoading);
    XCTAssertFalse([self.tableView.pullToRefreshControl isRefreshing]);
    XCTAssertNil(self.datasource.currentBatchRequest);
}

- (void)testFetchBatchCompletedCommonInsertBottom {
    BIBatchRequest *batchRequest = [[BIBatchRequest alloc] initWithCompletionBlock:nil];
    batchRequest.insertPosition = BIBatchInsertPositionBottom;
    BIMutableBatchResponse *batchResponse = [[BIMutableBatchResponse alloc] initWithBatchRequest:batchRequest];
    
    [self.tableView triggerInfiniteScrolling];
    [self.tableView triggerPullToRefresh];
    [self.datasource handleFetchBatchResponseCommon:batchResponse];
    XCTAssertEqual(self.tableView.infiniteScrollingState, BIInfiniteScrollingStateStopped);
    XCTAssertTrue([self.tableView.pullToRefreshControl isRefreshing]);
    XCTAssertNil(self.datasource.currentBatchRequest);
}


- (void)testFetchBatchCompletedCommonInsertOther {
    BIBatchRequest *batchRequest = [[BIBatchRequest alloc] initWithCompletionBlock:nil];
    batchRequest.insertPosition = 1;
    BIMutableBatchResponse *batchResponse = [[BIMutableBatchResponse alloc] initWithBatchRequest:batchRequest];
    
    [self.tableView triggerInfiniteScrolling];
    [self.tableView triggerPullToRefresh];
    [self.datasource handleFetchBatchResponseCommon:batchResponse];
    XCTAssertEqual(self.tableView.infiniteScrollingState, BIInfiniteScrollingStateLoading);
    XCTAssertTrue([self.tableView.pullToRefreshControl isRefreshing]);
    XCTAssertNil(self.datasource.currentBatchRequest);
}

#pragma mark - Test load

- (void)testLoad {
    XCTAssertEqualObjects(self.datasource.cellClass, [BITableViewCell class]);
    XCTAssert(self.datasource.cellIdentifier.length);
}

@end
