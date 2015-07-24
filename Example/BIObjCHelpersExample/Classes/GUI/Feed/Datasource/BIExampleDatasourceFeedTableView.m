//
//  BIExampleDatasourceFeedTableView.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 14/07/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIExampleDatasourceFeedTableView.h"
#import "BITableViewBatch.h"

const CGFloat kExampleDatasourceFeedMaxElements = 30;

@interface BIExampleDatasourceFeedTableView ()

@property (nonatomic, assign) NSUInteger countItems;

@end


@implementation BIExampleDatasourceFeedTableView

- (void)load {
    [super load];
    self.countItems = 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.countItems;
}

- (void)configureCell:(nonnull UITableViewCell *)cell atIndexPath:(nonnull NSIndexPath *)indexPath {
    [super configureCell:cell atIndexPath:indexPath];
    NSString *text = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    cell.textLabel.text = text;
}

- (void)fetchBatch:(nonnull BITableViewBatch *)batch {
    if (self.countItems > kExampleDatasourceFeedMaxElements) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            batch.completionBlock(nil, @[]);
        });
        return;
    }
    [super fetchBatch:batch];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSUInteger sectionIndex = batch.sectionIndex;
        NSUInteger newRowIndex = [self.tableView numberOfRowsInSection:sectionIndex];
        NSUInteger lastRowIndex = newRowIndex + batch.batchSize;
        self.countItems += batch.batchSize;
        NSMutableArray *mutableArray = [NSMutableArray new];
        for (NSUInteger index = newRowIndex; index < lastRowIndex; index++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:sectionIndex];
            [mutableArray addObject:indexPath];
        }
        batch.completionBlock(nil, [NSArray arrayWithArray:mutableArray]);
    });
}

@end
