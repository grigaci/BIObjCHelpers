//
//  BIDatasourceFeedCollectionView.m
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 8/31/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BIDatasourceFeedCollectionView.h"
#import "BICollectionViewActivityIndicatorReusableView.h"
#import "BICollectionViewCell.h"

@interface BIDatasourceFeedCollectionView ()

@property (nonatomic, strong, nullable, readwrite) BIBatch *currentBatch;

@property (nonatomic, assign) BOOL reloadIsOnTop;
@property (nonatomic, assign, readwrite) BOOL dataSourceIsDoneLoading;

@property (nonatomic, copy) NSString *footerViewIdentifier;

@end

@implementation BIDatasourceFeedCollectionView

@dynamic collectionView;
@synthesize cellClass = _cellClass;

+ (nonnull instancetype)datasourceWithBICollectionView:(nonnull BICollectionView *)collectionView {
    return [super datasourceWithCollectionView:collectionView];
}

#pragma mark - BIDatasourceBase methods

- (void)load {
    [super load];
    [self.collectionView registerClass:[BICollectionViewActivityIndicatorReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:self.footerViewIdentifier];
    __weak typeof(self) weakself = self;
    [self.collectionView setInfiniteScrollingCallback:^{
        BIBatch *batch = [weakself createNextBatch];
        [weakself fetchBatch:batch loadOnTop:NO];
        weakself.reloadIsOnTop = NO;
    }];
    [self.collectionView setPullToRefreshCallback:^{
        BIBatch *batch = [weakself createNextBatch];
        [weakself fetchBatch:batch loadOnTop:YES];
        weakself.reloadIsOnTop = YES;
    }];
}

// Overriden getter
- (Class)cellClass {
    if (!_cellClass) {
        _cellClass = [BICollectionViewCell class];
    }
    return _cellClass;
}

#pragma mark - Public methods

- (nonnull BIBatch *)createNextBatch {
    NSUInteger lastSectionIndex = [self.collectionView numberOfSections] - 1;
    NSUInteger batchSize = kDefaultBatchSize;
    __weak typeof(self) weakself = self;
    BIBatchCompletionBlock completionBlock = ^(NSError * __nullable error, NSArray * __nullable newIndexPaths) {
        [weakself handleFetchBatchResponse:error newIndexPaths:newIndexPaths];
        if (weakself.reloadIsOnTop) {
            [weakself.collectionView.refreshControl endRefreshing];
        }
    } ;
    BIBatch *batch = [[BIBatch alloc] initWithSection:lastSectionIndex
                                            batchSize:batchSize
                                      completionBlock:completionBlock];
    return batch;
}

- (void)fetchBatch:(nonnull BIBatch *)batch loadOnTop:(BOOL)loadOnTop {
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
    if (newIndexPaths.count) {
        [self.collectionView performBatchUpdates:^{
           [self.collectionView insertItemsAtIndexPaths:newIndexPaths];
        } completion:^(BOOL finished) {
            [self fetchBatchCompletedCommon];
        }];
    } else {
        self.dataSourceIsDoneLoading = YES;
        [self.collectionView.collectionViewLayout invalidateLayout];
    }
}

- (void)fetchBatchCompletedCommon {
    self.currentBatch = nil;
    if (!self.reloadIsOnTop) {
        self.collectionView.infiniteScrollingState = BIInfiniteScrollingStateStopped;
    }
}

#pragma mark - Properties

- (NSString *)footerViewIdentifier {
    if (!_footerViewIdentifier) {
        _footerViewIdentifier = [NSUUID UUID].UUIDString;
    }
    return _footerViewIdentifier;
}

#pragma mark - UICollectionViewDatasource Methods

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        BICollectionViewActivityIndicatorReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:self.footerViewIdentifier forIndexPath:indexPath];
        footerView.hidden = self.dataSourceIsDoneLoading;
        return footerView;
    }
    return nil;
}

@end
