//
//  LoadMoreView.m
//  Pods
//
//  Created by Mihai Chifor on 7/16/15.
//
//

#import "LoadMoreView.h"

@implementation LoadMoreView

- (void)setHidden:(BOOL)hidden {
    if (hidden) {
        [self.activityIndicator stopAnimating];
    } else {
        [self.activityIndicator startAnimating];
    }
    [super setHidden:hidden];
}

@end
