//
//  BIDatasourceFeedTableView.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 14/07/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceFeedTableView.h"
#import "BITableViewBatch.h"

#import <SVPullToRefresh/SVPullToRefresh.h>

@interface BIDatasourceFeedTableView ()

@property (nonatomic, strong, nullable, readwrite) BITableViewBatch *currentBatch;

@end


@implementation BIDatasourceFeedTableView

#pragma mark - BIDatasourceBase methods

- (void)load {
    [super load];
    __weak typeof(self) weakself = self;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        BITableViewBatch *batch = [weakself createNextBatch];
        [weakself fetchBatch:batch];
    }];
}

#pragma mark - Public methods

- (nonnull BITableViewBatch *)createNextBatch {
    NSUInteger lastSectionIndex = [self.tableView numberOfSections] - 1;
    NSUInteger batchSize = kDefaultTableViewBatchSize;
    __weak typeof(self) weakself = self;
    BITableViewBatchCompletionBlock completionBlock = ^(NSError * __nullable error, NSArray * __nullable newIndexPaths) {
        [weakself handleFetchBatchResponse:error newIndexPaths:newIndexPaths];
    } ;
    BITableViewBatch *batch = [[BITableViewBatch alloc] initWithSection:lastSectionIndex
                                                              batchSize:batchSize
                                                        completionBlock:completionBlock];
    return batch;
}

- (void)fetchBatch:(nonnull BITableViewBatch *)batch {
    self.currentBatch = batch;
}

- (void)handleFetchBatchResponse:(nullable NSError *)error
                   newIndexPaths:(nullable NSArray *)indexPaths {
    if (error) {
        [self fetchBatchCompletedWithFailure:error];
    } else {
        [self fetchBatchCompletedWithSuccess:indexPaths];
    }
}

- (void)fetchBatchCompletedWithFailure:(nonnull NSError *)error {
    [self fetchBatchCompletedCommon];
}

- (void)fetchBatchCompletedWithSuccess:(nonnull NSArray *)newIndexPaths {
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:newIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];

    [self fetchBatchCompletedCommon];
}

- (void)fetchBatchCompletedCommon {
    self.currentBatch = nil;
    [self.tableView.infiniteScrollingView stopAnimating];
}

@end
