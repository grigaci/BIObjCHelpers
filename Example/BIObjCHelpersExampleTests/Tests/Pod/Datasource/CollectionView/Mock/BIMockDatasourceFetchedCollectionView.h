//
//  BIMockDatasourceFetchedCollectionView.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/13/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

@import UIKit;

typedef void(^BIMockDatasourceFetchedCollectionViewInsertSections)(NSIndexSet *sections);
typedef void(^BIMockDatasourceFetchedCollectionViewDeleteSections)(NSIndexSet *sections);
typedef void(^BIMockDatasourceFetchedCollectionViewReloadSections)(NSIndexSet *sections);
typedef void(^BIMockDatasourceFetchedCollectionViewMoveSection)(NSInteger from, NSInteger to);

typedef void(^BIMockDatasourceFetchedCollectionViewInsertItems)(NSArray *items);
typedef void(^BIMockDatasourceFetchedCollectionViewDeleteItems)(NSArray *items);
typedef void(^BIMockDatasourceFetchedCollectionViewReloadItems)(NSArray *items);
typedef void(^BIMockDatasourceFetchedCollectionViewMoveItem)(NSIndexPath *from, NSIndexPath *to);

typedef void(^BIMockDatasourceFetchedCollectionReload)(void);

@interface BIMockDatasourceFetchedCollectionView : UICollectionView

@property (nonatomic, copy) BIMockDatasourceFetchedCollectionViewInsertSections insertSectionsCallback;
@property (nonatomic, copy) BIMockDatasourceFetchedCollectionViewDeleteSections deleteSectionsCallback;
@property (nonatomic, copy) BIMockDatasourceFetchedCollectionViewReloadSections reloadSectionsCallback;
@property (nonatomic, copy) BIMockDatasourceFetchedCollectionViewMoveSection moveSectionCallback;

@property (nonatomic, copy) BIMockDatasourceFetchedCollectionViewInsertItems insertItemsCallback;
@property (nonatomic, copy) BIMockDatasourceFetchedCollectionViewDeleteItems deleteItemsCallback;
@property (nonatomic, copy) BIMockDatasourceFetchedCollectionViewReloadItems reloadItemsCallback;
@property (nonatomic, copy) BIMockDatasourceFetchedCollectionViewMoveItem moveItemCallback;

@property (nonatomic, copy) BIMockDatasourceFetchedCollectionReload reloadDataCallback;

@end
