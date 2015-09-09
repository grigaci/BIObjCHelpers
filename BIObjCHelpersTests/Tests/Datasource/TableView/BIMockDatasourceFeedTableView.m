//
//  BIMockDatasourceFeedTableView.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 14/07/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIMockDatasourceFeedTableView.h"

@implementation BIMockDatasourceFeedTableView

- (nonnull BIBatchRequest *)createNextBatch {
    if (self.createNextBatchCallback) {
        return self.createNextBatchCallback();
    }
   return  [super createNextBatch];
}

- (void)fetchBatchRequest:(nonnull BIBatchRequest *)batchRequest {
    [super fetchBatchRequest:batchRequest];
    if (self.fetchBatchCallback) {
        self.fetchBatchCallback(batchRequest);
    }
}

- (void)handleFetchBatchResponseWithFailure:(nonnull BIBatchResponse *)batchResponse {
    [super handleFetchBatchResponseWithFailure:batchResponse];
    if (self.handleFetchBatchResponseWithFailureCallback) {
        self.handleFetchBatchResponseWithFailureCallback(batchResponse);
    }
}

- (void)handleFetchBatchResponseWithSuccess:(nonnull BIBatchResponse *)batchResponse {
    [super handleFetchBatchResponseWithSuccess:batchResponse];
    if (self.handleFetchBatchResponseWithSuccessCallback) {
        self.handleFetchBatchResponseWithSuccessCallback(batchResponse);
    }
}

@end
