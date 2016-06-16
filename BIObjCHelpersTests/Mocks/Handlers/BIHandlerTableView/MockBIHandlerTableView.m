//
//  MockBIHandlerTableView.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 24/07/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "MockBIHandlerTableView.h"

@implementation MockBIHandlerTableView

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewWillEndDragging:(nonnull UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout nonnull CGPoint *)targetContentOffset {
    if (self.scrollViewWillEndDraggingCallback) {
        self.scrollViewWillEndDraggingCallback(scrollView, velocity, targetContentOffset);
    }
}

@end
