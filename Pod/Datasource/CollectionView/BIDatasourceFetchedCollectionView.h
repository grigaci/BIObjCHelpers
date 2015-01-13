//
//  BIDatasourceFetchedCollectionView.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/13/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

@import UIKit;

#import "BIDatasourceFetchedResultsBase.h"

typedef void(^BIDatasourceFetchedCollectionViewConfigureCell)(id cell, NSIndexPath *indexPath);

@interface BIDatasourceFetchedCollectionView : BIDatasourceFetchedResultsBase<UICollectionViewDataSource>

+ (instancetype)datasourceWithCollectionView:(UICollectionView *)collectionView;
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

@property (nonatomic, readonly, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, strong) Class cellClass;
@property (nonatomic, copy) BIDatasourceFetchedCollectionViewConfigureCell configureCellBlock;

- (void)load;
- (void)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
