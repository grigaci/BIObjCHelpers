//
//  BIDatasourceTableView.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 04/05/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceBase.h"
#import "BITableView.h"

#import <UIKit/UIKit.h>

typedef void(^BIDatasourceTableViewConfigureCell)(id __nonnull cell, NSIndexPath * __nonnull indexPath);

@interface BIDatasourceTableView : BIDatasourceBase<UITableViewDataSource>

+ (nonnull instancetype)datasourceWithTableView:(nonnull UITableView *)tableView;
- (nonnull instancetype)initWithTableView:(nonnull UITableView *)tableView;

@property (nonatomic, readonly, strong, nonnull) UITableView *tableView;
@property (nonatomic, copy, nullable) NSString *cellIdentifier;
@property (nonatomic, strong, nullable) Class cellClass;
@property (nonatomic, copy, nullable) BIDatasourceTableViewConfigureCell configureCellBlock;
@property (nonatomic, copy, nullable) NSInteger(^numberOfRowsInSectionCallback)(NSInteger section);

- (void)configureCell:(nonnull UITableViewCell *)cell atIndexPath:(nonnull NSIndexPath *)indexPath;

@end
