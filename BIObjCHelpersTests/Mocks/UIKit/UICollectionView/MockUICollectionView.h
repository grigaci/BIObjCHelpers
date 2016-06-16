//
//  MockUICollectionView.h
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 6/16/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BIMockDatasourceFetchedCollectionViewInsertSections)(NSIndexSet *__nonnull sections);
typedef void(^BIMockDatasourceFetchedCollectionViewDeleteSections)(NSIndexSet *__nonnull sections);
typedef void(^BIMockDatasourceFetchedCollectionViewReloadSections)(NSIndexSet *__nonnull sections);
typedef void(^BIMockDatasourceFetchedCollectionViewMoveSection)(NSInteger from, NSInteger to);

typedef void(^BIMockDatasourceFetchedCollectionViewInsertItems)(NSArray *__nonnull items);
typedef void(^BIMockDatasourceFetchedCollectionViewDeleteItems)(NSArray *__nonnull items);
typedef void(^BIMockDatasourceFetchedCollectionViewReloadItems)(NSArray *__nonnull items);
typedef void(^BIMockDatasourceFetchedCollectionViewMoveItem)(NSIndexPath *__nonnull from, NSIndexPath *__nonnull to);

typedef void(^BIMockDatasourceFetchedCollectionReload)(void);

@interface MockUICollectionView : UICollectionView

@property (nonatomic, copy, nullable) BIMockDatasourceFetchedCollectionViewInsertSections insertSectionsCallback;
@property (nonatomic, copy, nullable) BIMockDatasourceFetchedCollectionViewDeleteSections deleteSectionsCallback;
@property (nonatomic, copy, nullable) BIMockDatasourceFetchedCollectionViewReloadSections reloadSectionsCallback;
@property (nonatomic, copy, nullable) BIMockDatasourceFetchedCollectionViewMoveSection moveSectionCallback;

@property (nonatomic, copy, nullable) BIMockDatasourceFetchedCollectionViewInsertItems insertItemsCallback;
@property (nonatomic, copy, nullable) BIMockDatasourceFetchedCollectionViewDeleteItems deleteItemsCallback;
@property (nonatomic, copy, nullable) BIMockDatasourceFetchedCollectionViewReloadItems reloadItemsCallback;
@property (nonatomic, copy, nullable) BIMockDatasourceFetchedCollectionViewMoveItem moveItemCallback;

@property (nonatomic, copy, nullable) BIMockDatasourceFetchedCollectionReload reloadDataCallback;

@property (nonatomic, copy, nullable) UICollectionViewCell *__nonnull(^dequeueReusableCellWithReuseIdentifier)(NSString *__nonnull identifier, NSIndexPath *__nonnull indexPath);

@end
