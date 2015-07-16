//
//  BITableView.m
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 7/16/15.
//  Copyright © 2015 iGama Apps. All rights reserved.
//

#import "BITableView.h"
#import "BIScrollDirection.h"

@interface BITableView () <UITableViewDelegate>

@end

@implementation BITableView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.delegate = self;
        self.enableInfiniteScrolling = YES;
        self.leadingScreens = .5f;
    }
    return self;
}

#pragma mark - Batch Fetching

- (void)scrollViewWillEndDragging:(nonnull UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout nonnull CGPoint *)targetContentOffset {
    if (!self.enableInfiniteScrolling) {
        return;
    }
    [self handleFetchBatchForTargetOffset:*targetContentOffset];
}

- (void)handleFetchBatchForTargetOffset:(CGPoint)targetOffset {
    if (BIDisplayShouldFetchBatch([self scrollDirection], self.bounds, self.contentSize, targetOffset, self.leadingScreens)) {
        if (self.infiniteScrollingCallback) {
            self.infiniteScrollingCallback();
        }
    }
}

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

@end
