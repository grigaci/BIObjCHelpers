    //
//  BIExampleFeedTableViewController.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 14/07/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIExampleFeedTableViewController.h"
#import "BIExampleDatasourceFeedTableView.h"

@interface BIExampleFeedTableViewController ()

@property (nonatomic, strong, nullable) BIExampleDatasourceFeedTableView *datasource;

@end

@implementation BIExampleFeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.datasource load];
}

- (BIExampleDatasourceFeedTableView *)datasource {
    if (!_datasource) {
        _datasource = [BIExampleDatasourceFeedTableView datasourceWithBITableView:self.tableView];
    }
    return _datasource;
}

@end
