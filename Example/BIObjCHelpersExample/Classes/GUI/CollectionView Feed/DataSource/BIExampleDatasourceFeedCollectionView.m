//
//  BIExampleDatasourceFeedCollectionView.m
//  BIObjCHelpersExample
//
//  Created by Mihai Chifor on 9/1/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIExampleDatasourceFeedCollectionView.h"
#import "BIExampleCollectionViewCell.h"

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

- (void)fetchBatch:(nonnull BIBatch *)batch loadOnTop:(BOOL)loadOnTop {
    if (self.countItems > kExampleDatasourceFeedCollectionViewMaxElements) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            batch.completionBlock(nil, @[]);
        });
        return;
    }
    [super fetchBatch:batch loadOnTop:loadOnTop];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSUInteger sectionIndex = batch.sectionIndex;
        NSUInteger newRowIndex = loadOnTop ? 0 : [self.collectionView numberOfItemsInSection:sectionIndex];
        NSUInteger lastRowIndex = loadOnTop ? batch.batchSize : newRowIndex + batch.batchSize;
        self.countItems += batch.batchSize;
        NSMutableArray *mutableArray = [NSMutableArray new];
        for (NSUInteger index = newRowIndex; index < lastRowIndex; index++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:sectionIndex];
            [mutableArray addObject:indexPath];
        }
        batch.completionBlock(nil, [mutableArray copy]);
    });
}

@end
