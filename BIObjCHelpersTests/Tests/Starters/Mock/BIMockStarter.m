//
//  BIMockStarter.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/13/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIMockStarter.h"

@implementation BIMockStarter

#pragma mark - BIStarter methods

- (void)start {
    if (self.startCallback) {
        self.startCallback();
    }
}

@end
