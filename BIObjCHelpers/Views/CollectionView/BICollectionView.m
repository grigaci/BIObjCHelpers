//
//  BICollectionView.m
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 8/31/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BICollectionView.h"
#import "BIActivityIndicatorContainerView.h"
#import "_BIScrollViewProxy.h"
#import "BIBatchHelper.h"

@interface BICollectionView () <UICollectionViewDelegate>

@property (nonatomic, strong, nonnull,  readwrite) BIActivityIndicatorContainerView *activityIndicatorContainer;
@property (nonatomic, strong, nullable, readwrite) _BIScrollViewProxy *proxyDelegate;
@property (nonatomic, weak, nullable, readwrite) BIDatasourceCollectionView *datasource;
@property (nonatomic, weak, nullable, readwrite) BIHandlerCollectionView *handler;

@property (nonatomic, strong, nonnull, readwrite) UIRefreshControl *refreshControl;

@end

@implementation BICollectionView

CGFloat const kBIRefreshControlCollectionViewHeight = 44.f;

#pragma mark - Init methods

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self BI_setupCollectionView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self BI_setupCollectionView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self BI_setupCollectionView];
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
    [super setDelegate:(id<UICollectionViewDelegate>)self.proxyDelegate];
}

- (id<UICollectionViewDelegate>)delegate {
    id<UICollectionViewDelegate> validDelegate = self.proxyDelegate.target;
    return validDelegate;
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
    
    if (!self.enableInfiniteScrolling || self.infiniteScrollingState == BIInfiniteScrollingStateLoading) {
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

- (BIRefreshControl * __nonnull)refreshControl {
    if (!_refreshControl) {
        CGRect refreshControlFrame = CGRectMake(0.f, -kBIRefreshControlCollectionViewHeight, CGRectGetWidth(self.bounds), kBIRefreshControlCollectionViewHeight);
        _refreshControl = [[UIRefreshControl alloc] initWithFrame:refreshControlFrame];
        [_refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
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
        [self.refreshControl removeFromSuperview];
    }
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

- (void)BI_setupCollectionView {
    self.proxyDelegate = [[_BIScrollViewProxy alloc] initWithTarget:nil interceptor:self];
    [super setDelegate:(id<UICollectionViewDelegate>)self.proxyDelegate];
    self.enableInfiniteScrolling = YES;
    self.enablePullToRefresh = YES;
    self.leadingScreens = kBILeadingScreens;
}

#pragma mark - Pull-To-Refresh Methods

- (void)refresh:(UIRefreshControl *)sender {
    if (self.pullToRefreshCallback) {
        self.pullToRefreshCallback();
    }
}

@end
