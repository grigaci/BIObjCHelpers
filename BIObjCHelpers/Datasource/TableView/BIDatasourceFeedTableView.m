//
//  BIDatasourceFeedTableView.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 14/07/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceFeedTableView.h"
#import "BIBatch.h"
#import "BITableViewCell.h"

@interface BIDatasourceFeedTableView ()

@property (nonatomic, strong, nullable, readwrite) BIBatch *currentBatch;

@end


@implementation BIDatasourceFeedTableView

@dynamic tableView;
@synthesize cellClass = _cellClass;

+ (nonnull instancetype)datasourceWithBITableView:(nonnull BITableView *)tableView {
    return [super datasourceWithTableView:tableView];
}

#pragma mark - BIDatasourceBase methods

- (void)load {
    [super load];
    __weak typeof(self) weakself = self;
    [self.tableView setInfiniteScrollingCallback:^{
        BIBatch *batch = [weakself createNextBatch];
        [weakself fetchBatch:batch];
    }];
}

// Overriden getter
- (Class)cellClass {
    if (!_cellClass) {
        _cellClass = [BITableViewCell class];
    }
    return _cellClass;
}

#pragma mark - Public methods

- (nonnull BIBatch *)createNextBatch {
    NSUInteger lastSectionIndex = [self.tableView numberOfSections] - 1;
    NSUInteger batchSize = kDefaultBatchSize;
    __weak typeof(self) weakself = self;
    BIBatchCompletionBlock completionBlock = ^(NSError * __nullable error, NSArray * __nullable newIndexPaths) {
        [weakself handleFetchBatchResponse:error newIndexPaths:newIndexPaths];
    } ;
    BIBatch *batch = [[BIBatch alloc] initWithSection:lastSectionIndex
                                                              batchSize:batchSize
                                                        completionBlock:completionBlock];
    return batch;
}

- (void)fetchBatch:(nonnull BIBatch *)batch {
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
    self.tableView.infiniteScrollingState = BIInfiniteScrollingStateStopped;
}

@end
