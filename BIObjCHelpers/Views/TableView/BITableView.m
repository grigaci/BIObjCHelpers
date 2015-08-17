//
//  BITableView.m
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 7/16/15.
//  Copyright © 2015 iGama Apps. All rights reserved.
//

#import "BITableView.h"
#import "BIScrollDirection.h"
#import "BIActivityIndicatorContainerView.h"
#import "_BITableViewProxy.h"

BOOL BIDisplayShouldFetchBatch(BIScrollDirection scrollDirection,
                               CGRect bounds,
                               CGSize contentSize,
                               CGPoint targetOffset,
                               CGFloat leadingScreens) {
    
    // only Up and Left scrolls are currently supported (tail loading)
    if (scrollDirection != BIScrollDirectionLeft && scrollDirection != BIScrollDirectionUp) {
        return NO;
    }
    
    // no fetching for null states
    if (leadingScreens <= 0.0 ||
        CGRectEqualToRect(bounds, CGRectZero)) {
        return NO;
    }
    
    CGFloat viewLength, offset, contentLength;
    
    if (scrollDirection == BIScrollDirectionUp) {
        viewLength = bounds.size.height;
        offset = targetOffset.y;
        contentLength = contentSize.height;
    } else { // horizontal
        viewLength = bounds.size.width;
        offset = targetOffset.x;
        contentLength = contentSize.width;
    }
    
    // target offset will always be 0 if the content size is smaller than the viewport
    BOOL hasSmallContent = offset == 0.0 && contentLength < viewLength;
    
    CGFloat triggerDistance = viewLength * leadingScreens;
    CGFloat remainingDistance = contentLength - viewLength - offset;
    
    return hasSmallContent || remainingDistance <= triggerDistance;
}

const CGFloat kBILeadingScreens = .5f;
const CGFloat kBITableFooterViewAnimationDuration = .25f;

@interface BITableView () <UITableViewDelegate>

@property (nonatomic, strong, nonnull,  readwrite) BIActivityIndicatorContainerView *activityIndicatorContainer;
@property (nonatomic, strong, nullable, readwrite) _BITableViewProxy *proxyDelegate;
@property (nonatomic, weak, nullable, readwrite) BIDatasourceTableView *datasource;
@property (nonatomic, weak, nullable, readwrite) BIHandlerTableView *handler;

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
    self.proxyDelegate = [[_BITableViewProxy alloc] initWithTarget:delegate interceptor:self];
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

#pragma mark - Private Methods

- (BIScrollDirection)scrollDirection {
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
    self.proxyDelegate = [[_BITableViewProxy alloc] initWithTarget:nil interceptor:self];
    [super setDelegate:(id<UITableViewDelegate>)self.proxyDelegate];
    self.enableInfiniteScrolling = YES;
    self.leadingScreens = kBILeadingScreens;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

@end
