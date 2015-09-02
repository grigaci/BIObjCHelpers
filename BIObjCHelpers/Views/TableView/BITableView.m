//
//  BITableView.m
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 7/16/15.
//  Copyright © 2015 iGama Apps. All rights reserved.
//

#import "BITableView.h"
#import "BIActivityIndicatorContainerView.h"
#import "_BIScrollViewProxy.h"
#import "BIBatchHelper.h"

@interface BITableView () <UITableViewDelegate>

@property (nonatomic, strong, nonnull,  readwrite) BIActivityIndicatorContainerView *activityIndicatorContainer;
@property (nonatomic, strong, nullable, readwrite) _BIScrollViewProxy *proxyDelegate;
@property (nonatomic, weak, nullable, readwrite) BIDatasourceTableView *datasource;
@property (nonatomic, weak, nullable, readwrite) BIHandlerTableView *handler;

@property (nonatomic, strong, nonnull, readwrite) UIRefreshControl *refreshControl;

@end

@implementation BITableView

#pragma mark - Init methods

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self BI_setupTableView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self BI_setupTableView];
    }
    return self;
}

#pragma mark - UITableView methods

- (void)setDelegate:(id<UITableViewDelegate>)delegate {
    /*!
     By setting the delegate to nil in a dealloc method causes a crash in the proxy class.
     Fix it by nilling the proxy in case delegate is nil.
     */
    if (!delegate) {
        [super setDelegate:nil];
        _proxyDelegate = nil;
        return;
    }
    self.proxyDelegate = [[_BIScrollViewProxy alloc] initWithTarget:delegate interceptor:self];
    [super setDelegate:(id<UITableViewDelegate>)self.proxyDelegate];
}

- (id<UITableViewDelegate>)delegate {
    id<UITableViewDelegate> validDelegate = self.proxyDelegate.target;
    return validDelegate;
}

- (void)setTableFooterView:(UIView *)tableFooterView {
    [UIView animateWithDuration:kBITableFooterViewAnimationDuration animations:^{
        [super setTableFooterView:tableFooterView];
    }];
}

#pragma mark - Public methods

- (void)triggerInfiniteScrolling {
    if (self.infiniteScrollingCallback) {
        self.infiniteScrollingState = BIInfiniteScrollingStateLoading;
        self.infiniteScrollingCallback();
    }
}

#pragma mark - Batch Fetching

- (void)scrollViewWillEndDragging:(nonnull UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout nonnull CGPoint *)targetContentOffset {
    // Call the method on the delegate class
    if ([self.proxyDelegate.target respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.proxyDelegate.target scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }

    if (!self.enableInfiniteScrolling) {
        return;
    }
    [self handleFetchBatchForTargetOffset:*targetContentOffset];
}

- (void)handleFetchBatchForTargetOffset:(CGPoint)targetOffset {
    if (BIDisplayShouldFetchBatch([self scrollDirection], self.bounds, self.contentSize, targetOffset, self.leadingScreens)) {
        if (self.infiniteScrollingCallback) {
            self.infiniteScrollingState = BIInfiniteScrollingStateLoading;
            self.infiniteScrollingCallback();
        }
    }
}

#pragma mark - Getters and Setters

- (BIActivityIndicatorContainerView *)activityIndicatorContainer {
    if (!_activityIndicatorContainer) {
        CGRect frame = CGRectMake(.0f, .0f, CGRectGetWidth(self.bounds), 44.f);
        _activityIndicatorContainer = [[BIActivityIndicatorContainerView alloc] initWithFrame:frame];
    }
    return _activityIndicatorContainer;
}

- (void)setInfiniteScrollingState:(BIInfiniteScrollingState)infiniteScrollingState {
    _infiniteScrollingState = infiniteScrollingState;
    UIView *newFooterView = nil;
    if (_infiniteScrollingState == BIInfiniteScrollingStateLoading &&
        !self.activityIndicatorContainer.superview ) {
            newFooterView = self.activityIndicatorContainer;
    }
    self.tableFooterView = newFooterView;
}

- (void)setEnablePullToRefresh:(BOOL)enablePullToRefresh {
    if (_enablePullToRefresh == enablePullToRefresh) {
        return;
    }
    _enablePullToRefresh = enablePullToRefresh;
    if (enablePullToRefresh) {
        self.alwaysBounceVertical = YES;
        [self addSubview:self.refreshControl];
    } else {
        if (self.refreshControl.superview) {
            [self.refreshControl removeFromSuperview];
        }
    }
}

- (UIRefreshControl * __nonnull)refreshControl {
    if (!_refreshControl) {
        _refreshControl = [UIRefreshControl new];
        [_refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
}

#pragma mark - Private Methods

- (BIScrollDetails)scrollDirection {
    CGPoint scrollVelocity = [self.panGestureRecognizer velocityInView:self.superview];
    BIScrollDetails direction = BIScrollDirectionNone;
    if (scrollVelocity.y > 0) {
        direction = BIScrollDirectionDown;
    } else {
        direction = BIScrollDirectionUp;
    }
    return direction;
}

- (void)BI_setupTableView {
    self.proxyDelegate = [[_BIScrollViewProxy alloc] initWithTarget:nil interceptor:self];
    [super setDelegate:(id<UITableViewDelegate>)self.proxyDelegate];
    self.enableInfiniteScrolling = YES;
    self.enablePullToRefresh = NO;
    self.leadingScreens = kBILeadingScreens;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.alwaysBounceVertical = YES;
}

#pragma mark - Pull-To-Refresh Methods

- (void)refresh:(UIRefreshControl *)sender {
    if (self.pullToRefreshCallback) {
        self.pullToRefreshCallback();
    }
}

@end
