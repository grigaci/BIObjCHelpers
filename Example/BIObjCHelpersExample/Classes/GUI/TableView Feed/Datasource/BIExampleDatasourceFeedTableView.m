//
//  BIExampleDatasourceFeedTableView.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 14/07/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIExampleDatasourceFeedTableView.h"
#import "BIBatchRequest.h"
#import "BIBatchResponse.h"
#import "BITableViewCell.h"

const CGFloat kExampleDatasourceFeedMaxElements = 30;

@interface BIExampleDatasourceFeedTableView ()

@property (nonatomic, assign) NSUInteger countItems;

@end


@implementation BIExampleDatasourceFeedTableView

- (void)load {
    [super load];
    self.tableView.rowHeight = 44.f;
    self.countItems = 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.countItems;
}

- (void)configureCell:(nonnull BITableViewCell *)cell atIndexPath:(nonnull NSIndexPath *)indexPath {
    [super configureCell:cell atIndexPath:indexPath];
    NSString *text = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    cell.textLabel.text = text;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)fetchBatchRequest:(nonnull BIBatchRequest *)batchRequest {
    if (self.countItems > kExampleDatasourceFeedMaxElements) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            BIBatchResponse *batchResponse = [[BIBatchResponse alloc] initWithBatchRequest:batchRequest
                                                                                     error:nil
                                                                             newIndexPaths:@[]];
            batchRequest.completionBlock(batchResponse);
            self.tableView.pullToRefreshEnabled = NO;
            self.tableView.infiniteScrollingEnabled = NO;
        });
        return;
    }
    [super fetchBatchRequest:batchRequest];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.countItems += batchRequest.batchSize;
        BIBatchResponse *batchResponse = [[BIBatchResponse alloc] initWithBatchRequest:batchRequest
                                                                             tableView:self.tableView
                                                                         countNewItems:batchRequest.batchSize];

        batchRequest.completionBlock(batchResponse);
    });
}

@end
