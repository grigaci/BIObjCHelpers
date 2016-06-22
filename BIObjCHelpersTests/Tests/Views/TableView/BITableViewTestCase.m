//
//  BITableViewTestCase.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 24/07/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BITableView.h"
#import "BIDatasourceFeedTableView.h"
#import "BIHandlerTableView.h"

#import "MockBIHandlerTableView.h"

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface BITableViewTestCase : XCTestCase

@property (nonatomic, strong, nullable) BITableView *tableView;
@property (nonatomic, strong, nullable) BIDatasourceTableView *datasource;
@property (nonatomic, strong, nullable) MockBIHandlerTableView *handler;
@property (nonatomic, assign) NSInteger countItems;

@end

@implementation BITableViewTestCase

#pragma mark - Setup methods

- (void)setUp {
    [super setUp];
    self.countItems = 10;
    self.tableView = [[BITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.datasource = [[BIDatasourceTableView alloc] initWithTableView:self.tableView];
    __weak typeof(self) weakself = self;
    self.datasource.numberOfRowsInSectionCallback = ^(NSInteger section) {
        return weakself.countItems;
    };
    self.handler = [[MockBIHandlerTableView alloc] initWithTableView:self.tableView];
    [self.datasource load];
}

- (void)tearDown {
    self.tableView = nil;
    self.datasource = nil;
    [super tearDown];
}

#pragma mark - Test delegate

- (void)testDelegate {
    XCTAssertNil(self.tableView.delegate);
    __block BOOL didSelectWasCalled = NO, willEndDraggingWasCalled = NO;
    [self.handler load];// handler sets itself as delegate
    XCTAssertEqual(self.tableView.delegate, self.handler);

    self.handler.didSelectRowCallback = ^(id __nonnull cell, NSIndexPath * __nonnull indexPath) {
        didSelectWasCalled = YES;
    };

    // Test that didSelectRowAtIndexPath method is called on the handler delegate
    NSInteger row = arc4random_uniform((u_int32_t)self.countItems);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:indexPath];
    XCTAssertTrue(didSelectWasCalled);
    
    // Test that scrollViewWillEndDragging method is called on the handler delegate also
    self.handler.scrollViewWillEndDraggingCallback = ^(UIScrollView * __nonnull scrollView, CGPoint velocity, CGPoint * __nonnull targetContentOffset) {
        willEndDraggingWasCalled = YES;
    };
    CGPoint velocity = CGPointMake(1, 1);
    CGPoint offset = CGPointMake(100, 100);
    [self.tableView.delegate scrollViewWillEndDragging:self.tableView withVelocity:velocity targetContentOffset:&offset];
    XCTAssertTrue(willEndDraggingWasCalled);
}


#pragma mark - Test pullToRefreshEnabled

- (void)test_pullToRefreshEnabledNo {
    XCTAssertFalse(self.tableView.isPullToRefreshEnabled); // Default value
    self.tableView.pullToRefreshEnabled = NO;
    XCTAssertNil(self.tableView.pullToRefreshControl);
    XCTAssertNil(self.tableView.pullToRefreshCallback);
}

- (void)test_pullToRefreshEnabledYes {
    __block BOOL wasCalled = NO;
    self.tableView.pullToRefreshEnabled = YES;
    XCTAssertTrue(self.tableView.pullToRefreshControl);
    self.tableView.pullToRefreshCallback = ^() {
        wasCalled = YES;
    };
    
    [self.tableView triggerPullToRefresh];
    XCTAssertTrue(wasCalled);
}

#pragma mark - Test infiniteScrollingEnabled

- (void)test_infiniteScrollingEnabledNO {
    XCTAssertFalse(self.tableView.isInfiniteScrollingEnabled);
    XCTAssertNil(self.tableView.infiniteScrollingCallback);
    XCTAssertNil(self.tableView.infiniteScrollingActivityIndicatorContainer);
}

- (void)test_infiniteScrollingEnabledYes {
    __block BOOL wasCalled = NO;
    self.tableView.infiniteScrollingEnabled = YES;
    self.tableView.infiniteScrollingCallback = ^() {
        wasCalled = YES;
    };

    [self.tableView triggerInfiniteScrolling];
    XCTAssertTrue(wasCalled);
    
    self.tableView.infiniteScrollingEnabled = NO;
    XCTAssertNil(self.tableView.infiniteScrollingActivityIndicatorContainer);
}

#pragma mark - Test infiniteScrollingState

- (void)test_infiniteScrollingState {
    self.tableView.infiniteScrollingEnabled = YES;
    self.tableView.infiniteScrollingState = BIInfiniteScrollingStateLoading;
    XCTAssertNotNil(self.tableView.tableFooterView);
    
    self.tableView.infiniteScrollingState = BIInfiniteScrollingStateStopped;
    XCTAssertNil(self.tableView.tableFooterView);
}

#pragma mark - Test datasource

- (void)test_datasource {
    BIDatasourceFeedTableView *feedDatasource = [BIDatasourceFeedTableView datasourceWithBITableView:self.tableView];
    XCTAssertNotNil(self.tableView.datasource);
    XCTAssertEqual(self.tableView.datasource, feedDatasource);
}

#pragma mark - Test handler

- (void)test_handler {
    BIHandlerTableView *handler = [BIHandlerTableView handlerWithTableView:self.tableView];
    XCTAssertNotNil(self.tableView.handler);
    XCTAssertEqual(self.tableView.handler, handler);
}

@end
