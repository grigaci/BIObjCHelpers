    //
//  BIExampleFeedTableViewController.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 14/07/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIExampleFeedTableViewController.h"
#import "BIExampleDatasourceFeedTableView.h"

#import <BIObjCHelpers/BITableView.h>
#import <BIObjCHelpers/BIHandlerTableView.h>

@interface BIExampleFeedTableViewController ()

@property (nonatomic, strong, nonnull) BIExampleDatasourceFeedTableView *datasource;
@property (nonatomic, strong, nonnull) BIHandlerTableView *handler;

@end

@implementation BIExampleFeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTableView];
    [self.datasource load];
    [self.handler load];
}

- (BIExampleDatasourceFeedTableView *)datasource {
    if (!_datasource) {
        _datasource = [BIExampleDatasourceFeedTableView datasourceWithBITableView:self.tableView];
    }
    return _datasource;
}

- (BIHandlerTableView *)handler {
    if (!_handler) {
        _handler = [[BIHandlerTableView alloc] initWithTableView:self.tableView];
        _handler.didSelectRowCallback = ^(id __nonnull cell, NSIndexPath * __nonnull indexPath) {
            NSLog(@"Did selected cell at row: %@", @(indexPath.row));
        };
    }
    return _handler;
}

- (void)configureTableView {
    self.tableView.pullToRefreshEnabled = YES;
    self.tableView.infiniteScrollingEnabled = YES;
}

@end
