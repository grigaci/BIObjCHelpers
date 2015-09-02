//
//  BICollectionView.h
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 8/31/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BIScrollDetails.h"
#import <UIKit/UIKit.h>

@class BIActivityIndicatorContainerView;
@class BIDatasourceCollectionView;
@class BIHandlerCollectionView;

/*!
 @brief CollectionView with infinite scrolling support.
 */
@interface BICollectionView : UICollectionView

/*!
 @callback infiniteScrollingCallback Used to notify dataSource to fetch the next batch
 */
@property (nonatomic, copy, nullable) void (^infiniteScrollingCallback)();

/*!
 @field enableInfiniteScrolling Specifies whether the scrolling of the collectionView is infinite or not
 @discussion If it is set to NO, no other batches are fetched. Default is YES
 */

@property (nonatomic, assign) BOOL enableInfiniteScrolling;

/*!
 @field leadingScreens Represents the number of screens left to scroll before triggering the fetch of the next batch
 @discussion Default is 0.5f (half of screen)
 */
@property (nonatomic, assign) CGFloat leadingScreens;

/*!
 @field enablePullToRefresh Specifies whether to trigger the pullToRefresCallback block or not, when a pull-to-refresh gesture for the collectionView is made.
 @discussion Default is YES.
 */
@property (nonatomic, assign) BOOL enablePullToRefresh;

/*!
 @field refreshControl Represents the view that is displayed on top of the collectionView when the pull-to-refresh gesture is made.
 */
@property (nonatomic, strong, nonnull, readonly) UIRefreshControl *refreshControl;

/*!
 @callback pullTorefreshCallback Used to notify the dataSource to reload.
 */
@property (nonatomic, copy, nullable) void (^pullToRefreshCallback)();
 
@property (nonatomic, assign) BIInfiniteScrollingState infiniteScrollingState;

/*!
 @brief Collection view's datasource. Valid only if a BIDatasourceCollectionView type was created with a reference to this table view.
 */
@property (nonatomic, weak, nullable, readonly) BIDatasourceCollectionView *datasource;

/*!
 @brief Table view's handler. Valid only if a BIHandlerCollectionView type was created with a reference to this table view.
 */
@property (nonatomic, weak, nullable, readonly) BIHandlerCollectionView *handler;

- (void)triggerInfiniteScrolling;


@end
