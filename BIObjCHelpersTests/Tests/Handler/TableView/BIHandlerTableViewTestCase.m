//
//  BIHandlerTableViewTestCase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 04/05/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIHandlerTableView.h"
#import "MockBITableView.h"

#import <XCTest/XCTest.h>

@interface BIHandlerTableViewTestCase : XCTestCase

@property (nonatomic, strong) BIHandlerTableView *handler;
@property (nonatomic, strong) MockBITableView *tableView;

@end

@implementation BIHandlerTableViewTestCase

#pragma mark - Setup methods

- (void)setUp {
    [super setUp];
    self.tableView = [MockBITableView new];
    self.handler = [BIHandlerTableView handlerWithTableView:self.tableView];

    self.tableView.cellForRowAtIndexPathCallback = ^(NSIndexPath *__nonnull indexPath) {
        return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString randomString]];
    };

    [self.handler load];
}

- (void)tearDown {
    self.handler = nil;
    self.tableView = nil;
    [super tearDown];
}

#pragma mark - Test Init

- (void)test_initBITableView {
    BITableView *tableView = [[BITableView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                                          style:UITableViewStylePlain];
    BIHandlerTableView *handler = [BIHandlerTableView handlerWithTableView:tableView];
    XCTAssertEqual(handler, tableView.handler);
}

#pragma mark - Test didSelectRowCallback

- (void)testDidSelectRowCallback {
    XCTAssertEqual(self.handler.tableView, self.tableView);
    
    __block UITableViewCell *receivedCell;
    __block NSIndexPath *receivedIndexPath;

    self.handler.didSelectRowCallback = ^(UITableViewCell *aCell, NSIndexPath *aIndexPath) {
        receivedCell = aCell;
        receivedIndexPath = aIndexPath;
    };

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:arc4random_uniform(10) inSection:arc4random_uniform(10)];
    [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:indexPath];
    
    XCTAssertNotNil(receivedCell);
    XCTAssertEqual(receivedIndexPath, indexPath);
}

#pragma mark - Test didSelectRowCallback

- (void)testDidDeselectRowCallback {
    XCTAssertEqual(self.handler.tableView, self.tableView);
    
    __block UITableViewCell *receivedCell;
    __block NSIndexPath *receivedIndexPath;
    
    self.handler.didDeselectRowCallback = ^(UITableViewCell *aCell, NSIndexPath *aIndexPath) {
        receivedCell = aCell;
        receivedIndexPath = aIndexPath;
    };
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:arc4random_uniform(10) inSection:arc4random_uniform(10)];
    [self.tableView.delegate tableView:self.tableView didDeselectRowAtIndexPath:indexPath];

    XCTAssertNotNil(receivedCell);
    XCTAssertEqual(receivedIndexPath, indexPath);
}

@end
