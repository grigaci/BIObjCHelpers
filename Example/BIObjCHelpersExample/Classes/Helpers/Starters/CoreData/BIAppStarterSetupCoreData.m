//
//  BIAppStarterSetupCoreData.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/13/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import <MagicalRecord/CoreData+MagicalRecord.h>

#import "BIAppStarterSetupCoreData.h"


@implementation BIAppStarterSetupCoreData

- (void)start {
    [MagicalRecord setupCoreDataStack];
}

@end
