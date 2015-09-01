//
//  BIHandlerCollectionView.h
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 8/31/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BIHandlerBase.h"

#import <UIKit/UIKit.h>

typedef void(^BIHandlerCollectionViewItemSelectionCallback)(id __nonnull cell, NSIndexPath * __nonnull indexPath);

@interface BIHandlerCollectionView : BIHandlerBase <UICollectionViewDelegateFlowLayout>

+ (nonnull instancetype)handlerWithCollectionView:(nonnull UICollectionView *)collectionView;
- (nonnull instancetype)initWithCollectionView:(nonnull UICollectionView *)collectionView;
- (nonnull instancetype)init NS_UNAVAILABLE;
+ (nonnull instancetype)new NS_UNAVAILABLE;

@property (nonatomic, readonly, strong, nonnull) UICollectionView *collectionView;

@property (nonatomic, copy, nullable) BIHandlerCollectionViewItemSelectionCallback didSelectItemCallback;
@property (nonatomic, copy, nullable) BIHandlerCollectionViewItemSelectionCallback didDeselectItemCallback;

@end
