//
//  BILaunchStartersFactory.h
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 10/13/15.
//  Copyright © 2015 iGama Apps. All rights reserved.
//

#import "BIStartersFactory.h"

#import <UIKit/UIKit.h>

@interface BILaunchStartersFactory : BIStartersFactory

- (__nonnull instancetype)init NS_UNAVAILABLE;
+ (__nonnull instancetype)new  NS_UNAVAILABLE;

- (__nonnull instancetype)initWithLaunchingOptions:(NSDictionary * __nonnull)launchOptions;

@property (nonatomic, strong, nonnull, readonly) UIApplication *application;
@property (nonatomic, strong, nonnull, readonly) NSDictionary *launchOptions;

@end
