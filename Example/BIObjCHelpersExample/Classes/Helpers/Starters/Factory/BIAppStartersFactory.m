//
//  BIAppStartersFactory.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/12/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIAppStartersFactory.h"
#import "BIAppStarterSetupCoreData.h"

@implementation BIAppStartersFactory

#pragma mark - BIStartersFactory methods

- (void)loadStarters {
    [self addStarter:[BIAppStarterSetupCoreData new]];
}

@end
