//
//  BIMockDatasourceFeedTableView.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 14/07/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIMockDatasourceFeedTableView.h"

@implementation BIMockDatasourceFeedTableView

- (nonnull BITableViewBatch *)createNextBatch {
    if (self.createNextBatchCallback) {
        return self.createNextBatchCallback();
    }
   return  [super createNextBatch];
}

- (void)fetchBatch:(nonnull BITableViewBatch *)batch {
    [super fetchBatch:batch];
    if (self.fetchBatchCallback) {
        self.fetchBatchCallback(batch);
    }
}

- (void)fetchBatchCompletedWithFailure:(nonnull NSError *)error {
    [super fetchBatchCompletedWithFailure:error];
    if (self.fetchBatchCompletedWithFailureCallback) {
        self.fetchBatchCompletedWithFailureCallback(error);
    }
}

- (void)fetchBatchCompletedWithSuccess:(nonnull NSArray *)newIndexPaths {
    [super fetchBatchCompletedWithSuccess:newIndexPaths];
    if (self.fetchBatchCompletedWithSuccessCallback) {
        self.fetchBatchCompletedWithSuccessCallback(newIndexPaths);
    }
}

@end
