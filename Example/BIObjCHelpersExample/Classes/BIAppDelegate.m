//
//  BIAppDelegate.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/2/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIAppDelegate.h"
#import "BIAppStartersFactory.h"

@interface BIAppDelegate ()

@end

@implementation BIAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[BIAppStartersFactory new] run];
    return YES;
}

@end
