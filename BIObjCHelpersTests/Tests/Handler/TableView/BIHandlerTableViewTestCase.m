//
//  BIHandlerTableViewTestCase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 04/05/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIHandlerTableView.h"
#import "BITableView.h"
#import <XCTest/XCTest.h>
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>


@interface BIHandlerTableViewTestCase : XCTestCase

@property (nonatomic, strong) BIHandlerTableView *handler;
@property (nonatomic, strong) BITableView *tableView;
@property (nonatomic, strong) UITableViewCell *cell;

@end

@implementation BIHandlerTableViewTestCase

#pragma mark - Setup methods

- (void)setUp {
    [super setUp];
    self.tableView = mock([BITableView class]);
    self.cell = mock([UITableViewCell class]);
    self.handler = [BIHandlerTableView handlerWithTableView:self.tableView];

    [given([self.tableView cellForRowAtIndexPath:anything()]) willReturn:self.cell];
    [given([self.tableView delegate]) willReturn:self.handler];

    [self.handler load];
}

- (void)tearDown {
    self.handler = nil;
    self.tableView = nil;
    self.cell = nil;
    [super tearDown];
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
    
    XCTAssertEqual(receivedCell, self.cell);
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

    XCTAssertEqual(receivedCell, self.cell);
    XCTAssertEqual(receivedIndexPath, indexPath);
}

@end
