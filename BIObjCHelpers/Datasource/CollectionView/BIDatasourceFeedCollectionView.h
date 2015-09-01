//
//  BIDatasourceFeedCollectionView.h
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 8/31/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BIDatasourceCollectionView.h"
#import "BICollectionView.h"
#import "BIBatch.h"

@interface BIDatasourceFeedCollectionView : BIDatasourceCollectionView

@property (nonatomic, strong, nullable, readonly) BIBatch *currentBatch;
@property (nonatomic, strong, readonly, nonnull) BICollectionView *collectionView;

@property (nonatomic, assign, readonly) BOOL dataSourceIsDoneLoading;

+ (nonnull instancetype)datasourceWithBICollectionView:(nonnull BICollectionView *)collectionView;
+ (nonnull instancetype)datasourceWithCollectionView:(nonnull UICollectionView *)collectionView NS_UNAVAILABLE;
- (nonnull instancetype)initWithCollectionView:(nonnull UICollectionView *)collectionView NS_UNAVAILABLE;

- (nonnull BIBatch *)createNextBatch;
- (void)fetchBatch:(nonnull BIBatch *)batch loadOnTop:(BOOL)loadOnTop;
- (void)fetchBatchCompletedWithFailure:(nonnull NSError *)error;
- (void)fetchBatchCompletedWithSuccess:(nonnull NSArray *)newIndexPaths;
- (void)fetchBatchCompletedCommon;

- (void)handleFetchBatchResponse:(nullable NSError *)error
                   newIndexPaths:(nullable NSArray *)indexPaths;

@end
