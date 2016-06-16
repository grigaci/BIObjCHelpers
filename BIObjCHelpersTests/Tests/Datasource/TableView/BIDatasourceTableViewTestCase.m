//
//  BIDatasourceTableViewTestCase.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 04/08/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BIDatasourceTableView.h"
#import "MockUITableView.h"
#import "MockUINib.h"

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface BIDatasourceTableViewTestCase : XCTestCase

@end

@implementation BIDatasourceTableViewTestCase

#pragma mark - Test init

- (void)test_initBITableView {
    BITableView *tableView = [[BITableView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                                          style:UITableViewStylePlain];
    BIDatasourceTableView *datasource = [BIDatasourceTableView datasourceWithTableView:tableView];
    XCTAssertEqual(datasource, tableView.datasource);
}

#pragma mark - Test load

- (void)testLoadNib {
    MockUITableView *tableView = [MockUITableView new];
    __block UINib *returnedNib;
    tableView.registerNibForCellReuseIdentifierCallback = ^(UINib *__nonnull nib, NSString *__nonnull identifier) {
        returnedNib = nib;
    };

    MockUINib *nib = [MockUINib new];
    BIDatasourceTableView *datasource = [BIDatasourceTableView datasourceWithTableView:tableView];
    datasource.cellNib = nib;
    
    [datasource load];
    
    XCTAssertNotNil(returnedNib);
}

- (void)testLoadCell {
    MockUITableView *tableView = [MockUITableView new];
    __block Class returnedClass;
    tableView.registerClassForCellReuseIdentifierCallback = ^(Class __nonnull cellClass, NSString *__nonnull identifier) {
        returnedClass = cellClass;
    };
    BIDatasourceTableView *datasource = [BIDatasourceTableView datasourceWithTableView:tableView];
    datasource.cellClass = [UITableViewCell class];
    
    [datasource load];
    
    XCTAssertNotNil(returnedClass);
}

#pragma mark - Test cellForRowAtIndexPath

- (void)testCellForRowAtIndexPathNoCellType {
    MockUITableView *tableView = [MockUITableView new];
    BIDatasourceTableView *datasource = [BIDatasourceTableView datasourceWithTableView:tableView];
    
    [datasource load];
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    XCTAssertThrows([datasource tableView:tableView cellForRowAtIndexPath:indexpath]);
}

#pragma mark - Test deleteRowsAtIndexPaths:withRowAnimation:

- (void)test_deleteRowsAtIndexPathsWithRowAnimation {
    MockUITableView *tableView = [MockUITableView new];
    __block NSArray *returnedIndexPaths;
    tableView.deleteRowsAtIndexPathsWithRowAnimationCallback = ^(NSArray * __nonnull indexPaths, UITableViewRowAnimation animation) {
        returnedIndexPaths = indexPaths;
    };
    BIDatasourceTableView *datasource = [BIDatasourceTableView datasourceWithTableView:tableView];
    [datasource load];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewRowAnimation animation = UITableViewRowAnimationMiddle;
    NSArray *indexPaths = @[indexPath];

    [datasource deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    XCTAssertEqual(returnedIndexPaths, indexPaths);
}

#pragma mark - Test test_insertRowsAtIndexPaths:models:withRowAnimation

- (void)test_insertRowsAtIndexPathsModelsWithRowAnimation {
    MockUITableView *tableView = [MockUITableView new];
    __block NSArray *returnedIndexPaths;
    tableView.insertRowsAtIndexPathsWithRowAnimationCallback = ^(NSArray * __nonnull indexPaths, UITableViewRowAnimation animation) {
        returnedIndexPaths = indexPaths;
    };
    BIDatasourceTableView *datasource = [BIDatasourceTableView datasourceWithTableView:tableView];
    [datasource load];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewRowAnimation animation = UITableViewRowAnimationMiddle;
    NSArray *indexPaths = @[indexPath];
    
    [datasource insertRowsAtIndexPaths:indexPaths models:@[] withRowAnimation:animation];
    XCTAssertEqual(returnedIndexPaths, indexPaths);
}

@end
