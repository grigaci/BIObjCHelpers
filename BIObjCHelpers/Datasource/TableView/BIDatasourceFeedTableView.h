//
//  BIDatasourceFeedTableView.h
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 14/07/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceTableView.h"
#import "BITableView.h"

@class BIBatchRequest;
@class BIBatchResponse;

/*!
 * Datasource for a BITableView with support for fetching batches.
 */
@interface BIDatasourceFeedTableView : BIDatasourceTableView

/*!
 * @brief Factory method for creating a feed table view datasource.
 * @param tableView The table view.
 */
+ (nonnull instancetype)datasourceWithBITableView:(nonnull BITableView *)tableView;

/*!
 * @brief Factory method for creating a feed table view datasource.
 * @param tableView The table view.
 */
- (nonnull instancetype)initWithBITableView:(nonnull BITableView *)tableView NS_DESIGNATED_INITIALIZER;

+ (nonnull instancetype)datasourceWithTableView:(nonnull UITableView *)tableView NS_UNAVAILABLE;
- (nonnull instancetype)initWithTableView:(nonnull UITableView *)tableView NS_UNAVAILABLE;

/*!
 * @brief Current batch that is being loaded.
 */
@property (nonatomic, strong, nullable, readonly) BIBatchRequest *currentBatchRequest;

/*!
 * @brief The tableview for whom is handling the data.
 */
@property (nonatomic, strong, readonly, nonnull) BITableView *tableView;

/*!
 * Create a new batch for fetching.
 * @return New batch.
 */
- (nonnull BIBatchRequest *)createNextBatch;

/*!
 * Fetches a given batch.
 * @param batch Given batch.
 */
- (void)fetchBatchRequest:(nonnull BIBatchRequest *)batchRequest;

/*!
 * @brief Handle a batch response.
 * @param batchResponse Batch response to handle.
 */
- (void)handleFetchBatchResponse:(nonnull BIBatchResponse *)batchResponse;

/*!
 * @brief Handle a batch response that failed.
 * @param batchResponse Batch response to handle.
 */
- (void)handleFetchBatchResponseWithFailure:(nonnull BIBatchResponse *)batchResponse;

/*!
 * @brief Handle a batch response that succeeded.
 * @param batchResponse Batch response to handle.
 */
- (void)handleFetchBatchResponseWithSuccess:(nonnull BIBatchResponse *)batchResponse;

/*!
 * @brief Handle a batch response .
 * @param batchResponse Batch response to handle.
 */
- (void)handleFetchBatchResponseCommon:(nonnull BIBatchResponse *)batchResponse;

@end
