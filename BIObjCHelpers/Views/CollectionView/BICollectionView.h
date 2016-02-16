//
//  BICollectionView.h
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 8/31/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BIScrollDetails.h"
#import <UIKit/UIKit.h>

@class BIDatasourceCollectionView;
@class BIHandlerCollectionView;
@class BITableAdditionalViewBase;

/*!
 @brief CollectionView with infinite scrolling support.
 */
@interface BICollectionView : UICollectionView

/*!
 @brief Specifies whether to trigger the pullToRefresCallback block or not, when a pull-to-refresh gesture for the collectionView is made. Default is NO.
 */
@property (nonatomic, assign, getter=isPullToRefreshEnabled) BOOL pullToRefreshEnabled;

/*!
 @brief Used to notify the datasource to reload.
 */
@property (nonatomic, copy, nullable) void (^pullToRefreshCallback)();

/*!
 @brief Represents the view that is displayed on top of the collectionView when the pull-to-refresh gesture is made.
 */
@property (nonatomic, strong, nullable, readonly) UIRefreshControl *pullToRefreshControl;


/*!
 @brief Specifies whether the scrolling of the collectionView is infinite or not. If it is set to NO, no other batches are fetched. Default is YES.
 */
@property (nonatomic, assign) BOOL enableInfiniteScrolling __deprecated_msg("Use infiniteScrollingEnabled instead");

/*!
 @brief Specifies whether the scrolling of the collectionView is infinite or not. If it is set to NO, no other batches are fetched. Default is NO
 */
@property (nonatomic, assign, getter=isInfiniteScrollingEnabled) BOOL infiniteScrollingEnabled;

/*!
 @brief Used to notify dataSource to fetch the next batch
 */
@property (nonatomic, copy, nullable) void (^infiniteScrollingCallback)();

/*!
 @brief Represents the number of screens left to scroll before triggering the fetch of the next batch. Default is 0.5f (half of screen)
 */
@property (nonatomic, assign) CGFloat leadingScreens __deprecated_msg("Use infiniteScrollingLeadingScreens instead");

/*!
 @brief Represents the number of screens left to scroll before triggering the fetch of the next batch. Default is 0.5f (half of screen)
 */
@property (nonatomic, assign) CGFloat infiniteScrollingLeadingScreens;

/*!
 @brief The current state of the infinite scrolling view.
 */
@property (nonatomic, assign) BIInfiniteScrollingState infiniteScrollingState;

/*!
 @brief Collection view's datasource. Valid only if a BIDatasourceCollectionView type was created with a reference to this collection view.
 */
@property (nonatomic, weak, nullable, readonly) BIDatasourceCollectionView *datasource;

/*!
 @brief collection view's handler. Valid only if a BIHandlerCollectionView type was created with a reference to this collection view.
 */
@property (nonatomic, weak, nullable, readonly) BIHandlerCollectionView *handler;

/*!
 Manual trigger pull to refresh.
 */
- (void)triggerPullToRefresh;

/*!
 Manual trigger the infinite scrolling.
 */
- (void)triggerInfiniteScrolling;

@end


/*!
 @brief Category for handling additional views such as loading, error or no content.
 */
@interface BICollectionView (AdditionalViews)

/*!
 @brief Currently used additional view when collection view is empty(no data to show).
 */
@property (nonatomic, strong, nullable, readonly) BITableAdditionalViewBase *additionalNoContentView;

/*!
 @brief Currently used additional view when collection view is empty due to a failed operation. Can be used
 to reload collection view content with a simple tap gesture.
 */
@property (nonatomic, strong, nullable, readonly) BITableAdditionalViewBase *additionalErrorNoContentView;

/*!
 @brief Currently used additional view when collection view is loading the initial data on first request, or after a failed initial request.
 */
@property (nonatomic, strong, nullable, readonly) BITableAdditionalViewBase *additionalLoadingContentView;

/*!
 @brief Currently visible additional view.
 */
@property (nonatomic, strong, nullable, readonly) BITableAdditionalViewBase *visibleAdditionalView;

/*!
 @brief Callback to create an no content additional view.
 */
@property (nonatomic, copy, nullable) BITableAdditionalViewBase * _Nullable (^createAdditionalNoContentViewCallback)(void);

/*!
 @brief Callback to create an error no content additional view.
 */
@property (nonatomic, copy, nullable) BITableAdditionalViewBase * _Nullable (^createAdditionalErrorNoContentViewCallback)(void);

/*!
 @brief Callback to create an loading additional view.
 */
@property (nonatomic, copy, nullable) BITableAdditionalViewBase * _Nullable (^createAdditionalLoadingContentViewCallback)(void);

/*!
 @brief Method to create an no content additional view.
 @return Additional view to show, or nil otherwise.
 */
- (nullable BITableAdditionalViewBase *)createAdditionalNoContentView;

/*!
 @brief Method to create an error no content additional view.
 @return Additional view to show, or nil otherwise.
 */
- (nullable BITableAdditionalViewBase *)createAdditionalErrorNoContentView;

/*!
 @brief Method to create an loading additional view.
 @return Additional view to show, or nil otherwise.
 */
- (nullable BITableAdditionalViewBase *)createAdditionalLoadingContentView;

/*!
 @brief Add any additional view to the collection. Will disable collection view scrolling.
 @param additionalView View to add.
 */
- (void)addGeneralAdditionalView:(nonnull BITableAdditionalViewBase *)additionalView;

/*!
 @brief Create and add an no content additional view to the collection. Will disable collection view scrolling.
 Will remove any previous additional view.
 */
- (void)addAdditionalNoContentView;

/*!
 @brief Create and add an error no content additional view to the collection. Will disable collection view scrolling.
 Will remove any previous additional view.
 */
- (void)addAdditionalErrorNoContentView;

/*!
 @brief Create and add an loading additional view to the collection. Will disable collection view scrolling.
 Will remove any previous additional view.
 */
- (void)addAdditionalLoadingContentView;

/*!
 @brief Remove a given additional view from the collection. Will enable collection view scrolling.
 @param additionalView View to remove.
 */
- (void)removeGeneralAdditionalView:(nonnull BITableAdditionalViewBase *)additionalView;

/*!
 @brief Remove currently visible additional view from the collection. Will enable collection view scrolling.
 */
- (void)removeVisibleAdditionalView;

/*!
 @brief Layout currently visible additional view.
 */
- (void)layoutAdditionalView;

@end
