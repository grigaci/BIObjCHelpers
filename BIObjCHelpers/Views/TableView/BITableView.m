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
#import "BIBatchHelpers.h"
#import "BITableAdditionalViewBase.h"
#import "BIDatasourceFeedTableView.h"

@interface BITableView () <UITableViewDelegate, BITableAdditionalViewBaseListener>

@property (nonatomic, strong, nullable,  readwrite) BIActivityIndicatorContainerView *infiniteScrollingActivityIndicatorContainer;
@property (nonatomic, strong, nullable, readwrite) _BIScrollViewProxy *proxyDelegate;
@property (nonatomic, strong, nullable, readwrite) UIRefreshControl *pullToRefreshControl;

@property (nonatomic, weak,   nullable, readwrite) BIDatasourceTableView *datasource;
@property (nonatomic, weak,   nullable, readwrite) BIHandlerTableView *handler;

@property (nonatomic, assign, getter=BI_isPullToRefreshEnabled) BOOL BI_pullToRefreshEnabled;
@property (nonatomic, assign, getter=BI_isInfiniteScrollingEnabled) BOOL BI_infiniteScrollingEnabled;

// AdditionalViews Category

@property (nonatomic, strong, nullable, readwrite) BITableAdditionalViewBase *additionalNoContentView;
@property (nonatomic, strong, nullable, readwrite) BITableAdditionalViewBase *additionalErrorNoContentView;
@property (nonatomic, strong, nullable, readwrite) BITableAdditionalViewBase *additionalLoadingContentView;
@property (nonatomic, strong, nullable, readwrite) BITableAdditionalViewBase *visibleAdditionalView;

@property (nonatomic, copy, nullable) BITableAdditionalViewBase * _Nullable (^createAdditionalNoContentViewCallback)(void);
@property (nonatomic, copy, nullable) BITableAdditionalViewBase * _Nullable (^createAdditionalErrorNoContentViewCallback)(void);
@property (nonatomic, copy, nullable) BITableAdditionalViewBase * _Nullable (^createAdditionalLoadingContentViewCallback)(void);

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

#pragma mark - Dealloc method

- (void)dealloc {
    [self.visibleAdditionalView unregisterAdditionalViewListeners:self];
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

- (void)triggerPullToRefresh {
    [self BI_createPullToRefreshControl];
    [self.pullToRefreshControl beginRefreshing];
    if (self.pullToRefreshCallback) {
        self.pullToRefreshCallback();
    }
}

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

    if (!self.isInfiniteScrollingEnabled) {
        return;
    }
    [self handleFetchBatchForTargetOffset:*targetContentOffset];
}

- (void)handleFetchBatchForTargetOffset:(CGPoint)targetOffset {
    if (BIDisplayShouldFetchBatch([self BI_scrollDirection], self.bounds, self.contentSize, targetOffset, self.infiniteScrollingLeadingScreens)) {
        if (self.infiniteScrollingCallback) {
            self.infiniteScrollingState = BIInfiniteScrollingStateLoading;
            self.infiniteScrollingCallback();
        }
    }
}

#pragma mark - Property methods

- (void)setPullToRefreshEnabled:(BOOL)pullToRefreshEnabled {
    _pullToRefreshEnabled = pullToRefreshEnabled;
    if (_pullToRefreshEnabled) {
        [self BI_createPullToRefreshControl];
        self.alwaysBounceVertical = YES;
        [self addSubview:self.pullToRefreshControl];
    } else {
        [self.pullToRefreshControl removeFromSuperview];
        self.pullToRefreshControl = nil;
    }
}

- (void)setInfiniteScrollingState:(BIInfiniteScrollingState)infiniteScrollingState {
    _infiniteScrollingState = infiniteScrollingState;
    if (self.isInfiniteScrollingEnabled && _infiniteScrollingState == BIInfiniteScrollingStateLoading) {
        [self BI_startInfiniteScrolling];
    }
    if (_infiniteScrollingState == BIInfiniteScrollingStateStopped) {
        self.tableFooterView = nil;
    }
}

- (void)setInfiniteScrollingEnabled:(BOOL)infiniteScrollingEnabled {
    _infiniteScrollingEnabled = infiniteScrollingEnabled;
    if (!infiniteScrollingEnabled) {
        if (self.tableFooterView &&
            self.tableFooterView == self.infiniteScrollingActivityIndicatorContainer) {
            self.infiniteScrollingActivityIndicatorContainer = nil;
            self.tableFooterView = nil;
        }
    }
}

#pragma mark - Private properties methods

- (void)setBI_infiniteScrollingEnabled:(BOOL)BI_infiniteScrollingEnabled {
    _BI_infiniteScrollingEnabled = BI_infiniteScrollingEnabled;
    if (!_BI_infiniteScrollingEnabled) {
        self.tableFooterView = nil;
    } else if (self.isInfiniteScrollingEnabled &&
            !self.infiniteScrollingActivityIndicatorContainer.superview ) {
            [self BI_createInfiniteScrollingActivityIndicatorContainer];
            self.tableFooterView = self.infiniteScrollingActivityIndicatorContainer;
    }
}

- (void)setBI_pullToRefreshEnabled:(BOOL)BI_pullToRefreshEnabled {
    _BI_pullToRefreshEnabled = BI_pullToRefreshEnabled;
    if (!_BI_pullToRefreshEnabled) {
        [self.pullToRefreshControl removeFromSuperview];
        self.pullToRefreshControl = nil;
    } else if (_BI_pullToRefreshEnabled && self.pullToRefreshEnabled && !self.pullToRefreshControl) {
        [self BI_createPullToRefreshControl];
        self.alwaysBounceVertical = YES;
        [self addSubview:self.pullToRefreshControl];
    }
}

#pragma mark - Action methods

- (void)BI_handlePullToRefreshAction:(UIRefreshControl *)sender {
    if (self.pullToRefreshCallback) {
        self.pullToRefreshCallback();
    }
}

#pragma mark - Private Methods

- (void)BI_startInfiniteScrolling {
    if (!self.infiniteScrollingActivityIndicatorContainer.superview) {
        [self BI_createInfiniteScrollingActivityIndicatorContainer];
        self.tableFooterView = self.infiniteScrollingActivityIndicatorContainer;
    }
}

- (BIScrollDirection)BI_scrollDirection {
    CGPoint scrollVelocity = [self.panGestureRecognizer velocityInView:self.superview];
    BIScrollDirection direction = BIScrollDirectionNone;
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
    _infiniteScrollingEnabled = NO;
    _pullToRefreshEnabled = NO;
    _BI_infiniteScrollingEnabled = YES;
    _BI_pullToRefreshEnabled = YES;
    _infiniteScrollingLeadingScreens = kBIDefaultInfiniteScrollingLeadingScreens;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)BI_createPullToRefreshControl {
    if (!_pullToRefreshControl) {
        _pullToRefreshControl = [UIRefreshControl new];
        [_pullToRefreshControl addTarget:self action:@selector(BI_handlePullToRefreshAction:) forControlEvents:UIControlEventValueChanged];
    }
}

- (void)BI_createInfiniteScrollingActivityIndicatorContainer {
    if (!_infiniteScrollingActivityIndicatorContainer) {
        CGRect frame = CGRectMake(.0f, .0f, CGRectGetWidth(self.bounds), 44.f);
        _infiniteScrollingActivityIndicatorContainer = [[BIActivityIndicatorContainerView alloc] initWithFrame:frame];
    }
}

@end


@implementation BITableView (AdditionalViews)

#pragma mark - BITableAdditionalViewBaseListener methods

- (void)didTapTableAdditionalView:(nonnull BITableAdditionalViewBase *)additionalView {
    if ([self.datasource isKindOfClass:[BIDatasourceFeedTableView class]]) {
        switch (additionalView.type) {
            case BITableAdditionalTypeErrorNoContentView: {
                BIDatasourceFeedTableView *feedDatasource = (BIDatasourceFeedTableView *)self.datasource;
                [feedDatasource triggerErrorNoContentTapToRetryRequest];
                break;
            }
            default:
                break;
        }
    }
}

#pragma mark - Public methods

- (nullable BITableAdditionalViewBase *)createAdditionalNoContentView {
    if (self.createAdditionalNoContentViewCallback) {
        return self.createAdditionalNoContentViewCallback();
    }
    return nil;
}

- (nullable BITableAdditionalViewBase *)createAdditionalErrorNoContentView {
    if (self.createAdditionalErrorNoContentViewCallback) {
        return self.createAdditionalErrorNoContentViewCallback();
    }
    return nil;
}

- (nullable BITableAdditionalViewBase *)createAdditionalLoadingContentView {
    if (self.createAdditionalLoadingContentViewCallback) {
        return self.createAdditionalLoadingContentViewCallback();
    }
    return nil;
}

- (void)addGeneralAdditionalView:(nonnull BITableAdditionalViewBase *)additionalView {
    if (self.visibleAdditionalView) {
        [self.visibleAdditionalView removeFromSuperview];
    }
    
    self.visibleAdditionalView = additionalView;
    [self layoutAdditionalView];
    [self addSubview:self.visibleAdditionalView];
    self.scrollEnabled = NO;
}

- (void)addAdditionalNoContentView {
    BITableAdditionalViewBase *noContentView = [self createAdditionalNoContentView];
    if (noContentView) {
        [self addGeneralAdditionalView:noContentView];
    }
}

- (void)addAdditionalErrorNoContentView {
    BITableAdditionalViewBase *errorNoContentView = [self createAdditionalErrorNoContentView];
    if (errorNoContentView) {
        [errorNoContentView registerAdditionalViewListeners:self];
        [self addGeneralAdditionalView:errorNoContentView];
    }
}

- (void)addAdditionalLoadingContentView {
    BITableAdditionalViewBase *loadingView = [self createAdditionalLoadingContentView];
    if (loadingView) {
        [self addGeneralAdditionalView:loadingView];
    }
}

- (void)removeGeneralAdditionalView:(nonnull BITableAdditionalViewBase *)additionalView {
    [additionalView removeFromSuperview];
    [additionalView unregisterAdditionalViewListeners:self];
    if (self.visibleAdditionalView == additionalView) {
        self.visibleAdditionalView = nil;
    }
    self.scrollEnabled = YES;
}

- (void)removeVisibleAdditionalView {
    if (self.visibleAdditionalView) {
        [self removeGeneralAdditionalView:self.visibleAdditionalView];
    }
}

- (void)layoutAdditionalView {
    if (self.visibleAdditionalView) {
        self.visibleAdditionalView.frame = self.bounds;
    }
}

@end
