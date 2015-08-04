//
//  BIDatasourceTableViewTestCase.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 04/08/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BIDatasourceTableView.h"

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

@interface BIDatasourceTableViewTestCase : XCTestCase

@property (nonatomic, strong, nullable) BIDatasourceTableView *datasource;

@end

@implementation BIDatasourceTableViewTestCase

#pragma mark - Setup methods

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Test load

- (void)testLoadNib {
    UITableView *tableView = mock([UITableView class]);
    UINib *nib = mock([UINib class]);
    BIDatasourceTableView *datasource = [BIDatasourceTableView datasourceWithTableView:tableView];
    datasource.cellNib = nib;
    
    [datasource load];
    
    [verifyCount(tableView, times(1)) registerNib:nib forCellReuseIdentifier:datasource.cellIdentifier];
}

- (void)testLoadCell {
    UITableView *tableView = mock([UITableView class]);
    Class cell = mockClass([UITableViewCell class]);
    BIDatasourceTableView *datasource = [BIDatasourceTableView datasourceWithTableView:tableView];
    datasource.cellClass = cell;
    
    [datasource load];
    
    [verifyCount(tableView, times(1)) registerClass:cell forCellReuseIdentifier:datasource.cellIdentifier];
}

#pragma mark - Test cellForRowAtIndexPath

- (void)testCellForRowAtIndexPathNoCellType {
    UITableView *tableView = mock([UITableView class]);
    BIDatasourceTableView *datasource = [BIDatasourceTableView datasourceWithTableView:tableView];
    
    [datasource load];
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    XCTAssertThrows([datasource tableView:tableView cellForRowAtIndexPath:indexpath]);
}

@end
