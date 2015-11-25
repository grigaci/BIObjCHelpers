//
//  BIDatasourceCollectionView.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 04/05/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceBase.h"

#import <UIKit/UIKit.h>

typedef void(^BIDatasourceCollectionViewConfigureCell)(id __nonnull cell, NSIndexPath * __nonnull indexPath);

@interface BIDatasourceCollectionView : BIDatasourceBase<UICollectionViewDataSource>

+ (nonnull instancetype)datasourceWithCollectionView:(nonnull UICollectionView *)collectionView;
- (nonnull instancetype)initWithCollectionView:(nonnull UICollectionView *)collectionView;
- (nonnull instancetype)init NS_UNAVAILABLE;
+ (nonnull instancetype)new NS_UNAVAILABLE;

@property (nonatomic, readonly, strong, nonnull) UICollectionView *collectionView;
@property (nonatomic, copy, nullable) NSString *cellIdentifier;
@property (nonatomic, strong, nullable) Class cellClass;
@property (nonatomic, strong, nullable) UINib *cellNib;
@property (nonatomic, copy, nullable) BIDatasourceCollectionViewConfigureCell configureCellBlock;

- (void)configureCell:(nonnull UICollectionViewCell *)cell atIndexPath:(nonnull NSIndexPath *)indexPath;

@end
