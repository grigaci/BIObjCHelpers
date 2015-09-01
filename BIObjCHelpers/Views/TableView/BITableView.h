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

/*!
 @brief Table view with infinite scrolling support.
 @note There is one limitation to this table view. Setting its delegate to nil causes the infinite scrolling
 to not work.
 */
@interface BITableView : UITableView

/*!
 @callback infiniteScrollingCallback Used to notify dataSource to fetch the next batch
 */
@property (nonatomic, copy, nullable) void (^infiniteScrollingCallback)();

/*!
 @field enableInfiniteScrolling specifies whether the scrolling of the tableView is infinite or not
 @discussion If it is set to NO, no other batches are fetched. Default is YES
 */

@property (nonatomic, assign) BOOL enableInfiniteScrolling;

/*!
 @field leadingScreens Represents the number of screens left to scroll before triggering the fetch of the next batch
 @discussion Default is 0.5f (half of screen)
 */
@property (nonatomic, assign) CGFloat leadingScreens;

/*!
 @field activityIndicatorContainer Activity indicator that is displayed on the tableView footer while a new batch is fetched
 @discussion Used as table footer view. Override it for further customization
 */
@property (nonatomic, strong, nonnull, readonly) BIActivityIndicatorContainerView *activityIndicatorContainer;

@property (nonatomic, assign) BIInfiniteScrollingState infiniteScrollingState;

/*!
 @brief Table view's datasource. Valid only if a BIDatasourceTableView type was created with a reference to this table view.
 */
@property (nonatomic, weak, nullable, readonly) BIDatasourceTableView *datasource;

/*!
 @brief Table view's handler. Valid only if a BIHandlerTableView type was created with a reference to this table view.
 */
@property (nonatomic, weak, nullable, readonly) BIHandlerTableView *handler;

- (void)triggerInfiniteScrolling;

@end
