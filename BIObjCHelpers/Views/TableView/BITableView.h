//
//  BITableView.h
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 7/16/15.
//  Copyright © 2015 iGama Apps. All rights reserved.
//

#import "BIScrollDetails.h"
#import <UIKit/UIKit.h>

@class BIActivityIndicatorContainerView;
@class BIDatasourceTableView;
@class BIHandlerTableView;
@class BITableAdditionalViewBase;

/*!
 @brief Table view with infinite scrolling support.
 @note There is one limitation to this table view. Setting its delegate to nil causes the infinite scrolling
 to not work.
 */
@interface BITableView : UITableView

/*!
 @brief Specifies whether to trigger the pullToRefresCallback block or not, when a pull-to-refresh gesture for the tableView is made. Default is NO.
 */
@property (nonatomic, assign, getter=isPullToRefreshEnabled) BOOL pullToRefreshEnabled;

/*!
 @brief Used to notify the datasource to reload.
 */
@property (nonatomic, copy, nullable) void (^pullToRefreshCallback)();

/*!
 @brief Represents the view that is displayed on top of the tableView when the pull-to-refresh gesture is made.
 */
@property (nonatomic, strong, nullable, readonly) UIRefreshControl *pullToRefreshControl;

/*!
 @brief Specifies whether the scrolling of the tableView is infinite or not. If it is set to NO, no other batches are fetched. Default is NO
 */
@property (nonatomic, assign, getter=isInfiniteScrollingEnabled) BOOL infiniteScrollingEnabled;

/*!
 @brief Used to notify dataSource to fetch the next batch
 */
@property (nonatomic, copy, nullable) void (^infiniteScrollingCallback)();

/*!
 @brief Represents the number of screens left to scroll before triggering the fetch of the next batch. Default is 0.5f (half of screen)
 */
@property (nonatomic, assign) CGFloat infiniteScrollingLeadingScreens;

/*!
 @brief Activity indicator that is displayed on the tableView footer while a new batch is fetched.
 Used as table footer view. Override it for further customization.
 */
@property (nonatomic, strong, nullable, readonly) BIActivityIndicatorContainerView *infiniteScrollingActivityIndicatorContainer;

/*!
 @brief The current state of the infinite scrolling view.
 */
@property (nonatomic, assign) BIInfiniteScrollingState infiniteScrollingState;

/*!
 @brief Table view's datasource. Valid only if a BIDatasourceTableView type was created with a reference to this table view.
 */
@property (nonatomic, weak, nullable, readonly) BIDatasourceTableView *datasource;

/*!
 @brief Table view's handler. Valid only if a BIHandlerTableView type was created with a reference to this table view.
 */
@property (nonatomic, weak, nullable, readonly) BIHandlerTableView *handler;

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
@interface BITableView (AdditionalViews)

/*!
 @brief Currently used additional view when table view is empty(no data to show).
 */
@property (nonatomic, strong, nullable, readonly) BITableAdditionalViewBase *additionalNoContentView;

/*!
 @brief Currently used additional view when table view is empty due to a failed operation. Can be used
 to reload table view content with a simple tap gesture.
 */
@property (nonatomic, strong, nullable, readonly) BITableAdditionalViewBase *additionalErrorNoContentView;

/*!
 @brief Currently used additional view when table view is loading the initial data on first request, or after a failed initial request.
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
 @brief Add any additional view to the table. Will disable table view scrolling.
 @param additionalView View to add.
 */
- (void)addGeneralAdditionalView:(nonnull BITableAdditionalViewBase *)additionalView;

/*!
 @brief Create and add an no content additional view to the table. Will disable table view scrolling.
 Will remove any previous additional view.
 */
- (void)addAdditionalNoContentView;

/*!
 @brief Create and add an error no content additional view to the table. Will disable table view scrolling.
 Will remove any previous additional view.
 */
- (void)addAdditionalErrorNoContentView;

/*!
 @brief Create and add an loading additional view to the table. Will disable table view scrolling.
 Will remove any previous additional view.
 */
- (void)addAdditionalLoadingContentView;

/*!
 @brief Remove a given additional view from the table. Will enable table view scrolling.
 @param additionalView View to remove.
 */
- (void)removeGeneralAdditionalView:(nonnull BITableAdditionalViewBase *)additionalView;

/*!
 @brief Remove currently visible additional view from the table. Will enable table view scrolling.
 */
- (void)removeVisibleAdditionalView;

/*!
 @brief Layout currently visible additional view.
 */
- (void)layoutAdditionalView;

@end
