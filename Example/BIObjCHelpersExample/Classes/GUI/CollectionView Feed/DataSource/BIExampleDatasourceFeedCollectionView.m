//
//  BIExampleDatasourceFeedCollectionView.m
//  BIObjCHelpersExample
//
//  Created by Mihai Chifor on 9/1/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIExampleDatasourceFeedCollectionView.h"
#import "BIExampleCollectionViewCell.h"
#import "BIBatchRequest.h"
#import "BIBatchResponse.h"
#import "BICollectionView.h"

const CGFloat kExampleDatasourceFeedCollectionViewMaxElements = 30;

@interface BIExampleDatasourceFeedCollectionView ()

@property (nonatomic, assign) NSUInteger countItems;

@end

@implementation BIExampleDatasourceFeedCollectionView

- (void)load {
    self.cellClass = [BIExampleCollectionViewCell class];
    [super load];
    self.countItems = 20;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.countItems;
}

- (void)configureCell:(nonnull UICollectionViewCell *)cell atIndexPath:(nonnull NSIndexPath *)indexPath {
    [super configureCell:cell atIndexPath:indexPath];
    
    BIExampleCollectionViewCell *exampleCell = (BIExampleCollectionViewCell *)cell;
    exampleCell.title = [NSString stringWithFormat:@"%ld", indexPath.row];
}

- (void)fetchBatchRequest:(nonnull BIBatchRequest *)batchRequest {
    if (self.countItems > kExampleDatasourceFeedCollectionViewMaxElements) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            BIMutableBatchResponse *batchResponse = [[BIMutableBatchResponse alloc] initWithBatchRequest:batchRequest];
            batchResponse.indexPaths = @[];
            batchRequest.completionBlock(batchResponse);
            self.collectionView.pullToRefreshEnabled = NO;
            self.collectionView.infiniteScrollingEnabled = NO;

        });
        return;
    }
    [super fetchBatchRequest:batchRequest];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        BIMutableBatchResponse *batchResponse = [[BIMutableBatchResponse alloc] initWithBatchRequest:batchRequest];
        [batchResponse createIndexPaths:batchRequest.batchSize countSectionItems:self.countItems];
        self.countItems += batchRequest.batchSize;
        batchRequest.completionBlock(batchResponse);
    });
}

@end
