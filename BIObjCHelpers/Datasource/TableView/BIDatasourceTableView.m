//
//  BIDatasourceTableView.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 04/05/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceTableView.h"

@interface BIDatasourceTableView ()

@property (nonatomic, readwrite, strong, nonnull) UITableView *tableView;

@end


@implementation BIDatasourceTableView

#pragma mark - Init methods

+ (instancetype)datasourceWithTableView:(UITableView *)tableView {
    return [[[self class] alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    NSParameterAssert(tableView);
    self = [super init];
    if (self) {
        self.tableView = tableView;
        self.tableView.dataSource = self;
    }
    return self;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if (self.configureCellBlock) {
        self.configureCellBlock(cell, indexPath);
    }
}

- (void)load {
    [super load];
    if (self.cellClass) {
        [self.tableView registerClass:self.cellClass forCellReuseIdentifier:self.cellIdentifier];
    } else if (self.cellNib) {
        [self.tableView registerNib:self.cellNib forCellReuseIdentifier:self.cellIdentifier];
    }
}

#pragma mark - Property methods

- (NSString *)cellIdentifier {
    if (!_cellIdentifier) {
        _cellIdentifier = [NSUUID UUID].UUIDString;
    }
    return _cellIdentifier;
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.numberOfRowsInSectionCallback) {
        return self.numberOfRowsInSectionCallback(section);
    }

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert(self.cellClass || self.cellNib, @"cellClass or cellNib must be specified");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath: indexPath];
    if (!cell) {
        cell = [[self.cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
    }
    [self configureCell: cell atIndexPath: indexPath];
    return cell;
}

@end
