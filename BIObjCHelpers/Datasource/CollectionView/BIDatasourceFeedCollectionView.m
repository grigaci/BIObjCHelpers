//
//  BIDatasourceFeedCollectionView.m
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 8/31/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BIDatasourceFeedCollectionView.h"
#import "BICollectionViewActivityIndicatorReusableView.h"
#import "BIBatchRequest.h"
#import "BIBatchResponse.h"

@interface BIDatasourceFeedCollectionView ()

@property (nonatomic, strong, nullable, readwrite) BIBatchRequest *currentBatchRequest;
@property (nonatomic, copy) NSString *footerViewIdentifier;

@end

@implementation BIDatasourceFeedCollectionView

@dynamic collectionView;
@synthesize cellClass = _cellClass;

#pragma mark - Factory methods

+ (nonnull instancetype)datasourceWithBICollectionView:(nonnull BICollectionView *)collectionView {
    return [[self alloc] initWithBICollectionView:collectionView];
}

#pragma mark - Init methods

- (nonnull instancetype)initWithBICollectionView:(nonnull BICollectionView *)collectionView {
    return [super initWithCollectionView:collectionView];
}

#pragma mark - BIDatasourceBase methods

- (void)load {
    [super load];
    [self.collectionView registerClass:[BICollectionViewActivityIndicatorReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:self.footerViewIdentifier];
    __weak typeof(self) weakself = self;
    [self.collectionView setInfiniteScrollingCallback:^{
        BIBatchRequest *batch = [weakself createNextBatch];
        batch.insertPosition = BIBatchInsertPositionBottom;
        [weakself fetchBatchRequest:batch];
    }];
    [self.collectionView setPullToRefreshCallback:^{
        BIBatchRequest *batch = [weakself createNextBatch];
        batch.insertPosition = BIBatchInsertPositionTop;
        [weakself fetchBatchRequest:batch];
    }];
}

- (Class)cellClass {
    if (!_cellClass) {
        _cellClass = [UICollectionViewCell class];
    }
    return _cellClass;
}

#pragma mark - Public methods

- (nonnull BIBatchRequest *)createNextBatch {
    NSUInteger lastSectionIndex = [self.collectionView numberOfSections] - 1;
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
    NSArray *newIndexPaths = batchResponse.indexPaths;
    if (newIndexPaths.count) {
        [self.collectionView performBatchUpdates:^{
           [self.collectionView insertItemsAtIndexPaths:newIndexPaths];
        } completion:^(BOOL finished) {
            [self handleFetchBatchResponseCommon:batchResponse];
        }];
    } else {
        [self.collectionView.collectionViewLayout invalidateLayout];
        [self handleFetchBatchResponseCommon:batchResponse];
    }
}

- (void)handleFetchBatchResponseCommon:(nonnull BIBatchResponse *)batchResponse {
    self.currentBatchRequest = nil;
    switch (batchResponse.batchRequest.insertPosition) {
        case BIBatchInsertPositionTop:
            [self.collectionView.pullToRefreshControl endRefreshing];
            break;
        case BIBatchInsertPositionBottom:
            self.collectionView.infiniteScrollingState = BIInfiniteScrollingStateStopped;
            break;
        default:
            break;
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
        footerView.hidden = NO;
        return footerView;
    }
    return nil;
}

@end
