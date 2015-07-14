//
//  BIDatasourceFeedTableView.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 14/07/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceTableView.h"

@class BITableViewBatch;

@interface BIDatasourceFeedTableView : BIDatasourceTableView

@property (nonatomic, strong, nullable, readonly) BITableViewBatch *currentBatch;

- (nonnull BITableViewBatch *)createNextBatch;
- (void)fetchBatch:(nonnull BITableViewBatch *)batch;
- (void)fetchBatchCompletedWithFailure:(nonnull NSError *)error;
- (void)fetchBatchCompletedWithSuccess:(nonnull NSArray *)newIndexPaths;
- (void)fetchBatchCompletedCommon;

- (void)handleFetchBatchResponse:(nullable NSError *)error
                   newIndexPaths:(nullable NSArray *)indexPaths;

@end
