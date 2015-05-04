//
//  BIDatasourceTableView.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 04/05/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceBase.h"

@import UIKit;

typedef void(^BIDatasourceTableViewConfigureCell)(id cell, NSIndexPath *indexPath);

@interface BIDatasourceTableView : BIDatasourceBase<UITableViewDataSource>

+ (instancetype)datasourceWithTableView:(UITableView *)tableView;
- (instancetype)initWithTableView:(UITableView *)tableView;

@property (nonatomic, readonly, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, strong) Class cellClass;
@property (nonatomic, copy) BIDatasourceTableViewConfigureCell configureCellBlock;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
