//
//  BIDatasourceFeedCollectionView.h
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 8/31/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BIDatasourceCollectionView.h"
#import "BICollectionView.h"

@class BIBatchRequest;
@class BIBatchResponse;

@interface BIDatasourceFeedCollectionView : BIDatasourceCollectionView

+ (nonnull instancetype)datasourceWithBICollectionView:(nonnull BICollectionView *)collectionView;
- (nonnull instancetype)initWithBICollectionView:(nonnull BICollectionView *)collectionView NS_DESIGNATED_INITIALIZER;
+ (nonnull instancetype)datasourceWithCollectionView:(nonnull UICollectionView *)collectionView NS_UNAVAILABLE;
- (nonnull instancetype)initWithCollectionView:(nonnull UICollectionView *)collectionView NS_UNAVAILABLE;

/*!
 * @brief Current batch that is being loaded.
 */
@property (nonatomic, strong, nullable, readonly) BIBatchRequest *currentBatchRequest;

/*!
 * @brief The collection view for whom is handling the data.
 */
@property (nonatomic, strong, nonnull, readonly) BICollectionView *collectionView;

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
