//
//  BIRefreshControl.m
//  Pods
//
//  Created by Mihai Chifor on 9/1/15.
//
//

#import "BIRefreshControl.h"

@implementation BIRefreshControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)containingScrollViewDidEndDragging:(UIScrollView *)containingScrollView {
    CGFloat minOffsetToTriggerRefresh = 50.0f;
    if (containingScrollView.contentOffset.y <= -minOffsetToTriggerRefresh) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

@end
