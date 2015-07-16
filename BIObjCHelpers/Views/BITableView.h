//
//  BITableView.h
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 7/16/15.
//  Copyright © 2015 iGama Apps. All rights reserved.
//

#import "BIScrollDirection.h"

#import <UIKit/UIKit.h>

/*!
 @typedef BIInfiniteScrollingState
 @abstract Represents the state of the tableView infinite scroll
 @field BIInfiniteScrollingStateStopped The tableView is currently not fetching any batches
 @field BIInfiniteScrollingStateLoading The tableView is currently fetching batches
 */
typedef NS_OPTIONS(NSInteger, BIInfiniteScrollingState) {
    BIInfiniteScrollingStateStopped = 0,
    BIInfiniteScrollingStateLoading = 1
};

/*!
 @abstract Determine if batch fetching should begin based on the state of the parameters.
 @param scrollDirection The current scrolling direction of the scroll view.
 @param bounds The bounds of the scrollview.
 @param contentSize The content size of the scrollview.
 @param targetOffset The offset that the scrollview will scroll to.
 @param leadingScreens How many screens in the remaining distance will trigger batch fetching.
 @return Whether or not the current state should proceed with batch fetching.
 @discussion This method is broken into a category for unit testing purposes and should be used with the BITableView and
 * BICollectionView batch fetching API.
 */
extern BOOL BIDisplayShouldFetchBatch(BIScrollDirection scrollDirection,
                                      CGRect bounds,
                                      CGSize contentSize,
                                      CGPoint targetOffset,
                                      CGFloat leadingScreens);

@interface BITableView : UITableView

/*!
 @callback infiniteScrollingCallback Used to notify dataSource to fetch the next batch
 */
@property (nonatomic, copy) void (^infiniteScrollingCallback)();

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
 @field activityIndicatorView Activity indicator that is displayed on the tableView footer while a new batch is fetched
 @discussion Override it for further customization
 */
@property (nonatomic, strong) UIView *activityIndicatorView;

@property (nonatomic, assign) BIInfiniteScrollingState infiniteScrollingState;

- (void)triggerInfiniteScrolling;

@end
