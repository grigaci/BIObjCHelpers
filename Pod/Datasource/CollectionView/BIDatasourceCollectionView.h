//
//  BIDatasourceCollectionView.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 04/05/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceBase.h"

@import UIKit;

typedef void(^BIDatasourceFetchedCollectionViewConfigureCell)(id cell, NSIndexPath *indexPath);

@interface BIDatasourceCollectionView : BIDatasourceBase<UICollectionViewDataSource>

+ (instancetype)datasourceWithCollectionView:(UICollectionView *)collectionView;
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

@property (nonatomic, readonly, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, strong) Class cellClass;
@property (nonatomic, copy) BIDatasourceFetchedCollectionViewConfigureCell configureCellBlock;

- (void)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
