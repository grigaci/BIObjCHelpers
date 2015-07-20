//
//  BIActivityIndicatorContainerView.h
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 20/07/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIActivityIndicatorContainerView : UIView

- (nonnull instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

@property (nonatomic, strong, nonnull, readonly) UIActivityIndicatorView *activityIndicatorView;

@end
