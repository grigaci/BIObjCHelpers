//
//  BIDatasourceFetchedTableView.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/12/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

@import UIKit;

#import "BIDatasourceFetchedResultsBase.h"

typedef void(^BIDatasourceFetchedTableViewConfigureCell)(id cell, NSIndexPath *indexPath);

@interface BIDatasourceFetchedTableView : BIDatasourceFetchedResultsBase<UITableViewDataSource>

+ (instancetype)datasourceWithTableView:(UITableView *)tableView;
- (instancetype)initWithTableView:(UITableView *)tableView;

@property (nonatomic, readonly, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, strong) Class cellClass;
@property (nonatomic, copy) BIDatasourceFetchedTableViewConfigureCell configureCellBlock;

- (void)load;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
