//
//  BIDatasourceFeedTableView.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 14/07/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceFeedTableView.h"
#import "BIBatchRequest.h"
#import "BIBatchResponse.h"
#import "BITableViewCell.h"

@interface BIDatasourceFeedTableView ()

@property (nonatomic, strong, nullable, readwrite) BIBatchRequest *currentBatchRequest;

@end


@implementation BIDatasourceFeedTableView

@dynamic tableView;
@synthesize cellClass = _cellClass;

#pragma mark - Factory methods

+ (nonnull instancetype)datasourceWithBITableView:(nonnull BITableView *)tableView {
    return [[self alloc] initWithBITableView:tableView];
}

#pragma mark - Init methods

- (nonnull instancetype)initWithBITableView:(nonnull BITableView *)tableView  {
    self = [super initWithTableView:tableView];
    if (self) {
        self.cellClass = [BITableViewCell class];
    }
    return self;
}

#pragma mark - BIDatasourceBase methods

- (void)load {
    [super load];
    __weak typeof(self) weakself = self;
    [self.tableView setInfiniteScrollingCallback:^{
        BIBatchRequest *batch = [weakself createNextBatch];
        batch.insertPosition = BIBatchInsertPositionBottom;
        [weakself fetchBatchRequest:batch];
    }];
    [self.tableView setPullToRefreshCallback:^{
        BIBatchRequest *batch = [weakself createNextBatch];
        batch.insertPosition = BIBatchInsertPositionTop;
        [weakself fetchBatchRequest:batch];
    }];
}

#pragma mark - Public methods

- (nonnull BIBatchRequest *)createNextBatch {
    NSUInteger lastSectionIndex = [self.tableView numberOfSections] - 1;
    NSUInteger batchSize = kDefaultBatchRequestSize;
    __weak typeof(self) weakself = self;
    BIBatchRequestCompletionBlock completionBlock = ^(BIBatchResponse *batchResponse) {
        [weakself handleFetchBatchResponse:batchResponse];
    };
    BIBatchRequest *batch = [[BIBatchRequest alloc] initWithSection:lastSectionIndex
                                                          batchSize:batchSize
                                                    completionBlock:completionBlock];
    return batch;
}

- (void)fetchBatchRequest:(nonnull BIBatchRequest *)batchRequest {
    self.currentBatchRequest = batchRequest;
}

- (void)handleFetchBatchResponse:(nonnull BIBatchResponse *)batchResponse {
    if (batchResponse.error) {
        [self handleFetchBatchResponseWithFailure:batchResponse];
    } else {
        [self handleFetchBatchResponseWithSuccess:batchResponse];
    }
}

- (void)handleFetchBatchResponseWithFailure:(nonnull BIBatchResponse *)batchResponse {
    [self handleFetchBatchResponseCommon:batchResponse];
}

- (void)handleFetchBatchResponseWithSuccess:(nonnull BIBatchResponse *)batchResponse {
    if (batchResponse.indexPaths.count) {
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:batchResponse.indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    }
    [self handleFetchBatchResponseCommon:batchResponse];
}

- (void)handleFetchBatchResponseCommon:(nonnull BIBatchResponse *)batchResponse {
    self.currentBatchRequest = nil;
    switch (batchResponse.batchRequest.insertPosition) {
        case BIBatchInsertPositionTop:
            [self.tableView.pullToRefreshControl endRefreshing];
            break;
        case BIBatchInsertPositionBottom:
            self.tableView.infiniteScrollingState = BIInfiniteScrollingStateStopped;
            break;
        default:
            break;
    }
}

@end
