//
//  BIDatasourceFeedTableView.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 14/07/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceTableView.h"
#import "BITableView.h"

@class BIBatch;

@interface BIDatasourceFeedTableView : BIDatasourceTableView

@property (nonatomic, strong, nullable, readonly) BIBatch *currentBatch;
@property (nonatomic, strong, readonly, nonnull) BITableView *tableView;

+ (nonnull instancetype)datasourceWithBITableView:(nonnull BITableView *)tableView;
+ (nonnull instancetype)datasourceWithTableView:(nonnull UITableView *)tableView NS_UNAVAILABLE;
- (nonnull instancetype)initWithTableView:(nonnull UITableView *)tableView NS_UNAVAILABLE;

- (nonnull BIBatch *)createNextBatch;
- (void)fetchBatch:(nonnull BIBatch *)batch loadOnTop:(BOOL)loadOnTop;
- (void)fetchBatchCompletedWithFailure:(nonnull NSError *)error;
- (void)fetchBatchCompletedWithSuccess:(nonnull NSArray *)newIndexPaths;
- (void)fetchBatchCompletedCommon;

- (void)handleFetchBatchResponse:(nullable NSError *)error
                   newIndexPaths:(nullable NSArray *)indexPaths;

@end
