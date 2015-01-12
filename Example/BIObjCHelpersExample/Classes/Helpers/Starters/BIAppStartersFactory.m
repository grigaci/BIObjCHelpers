//
//  BIAppStartersFactory.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/12/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import <MagicalRecord/CoreData+MagicalRecord.h>

#import "BIAppStartersFactory.h"

@interface BIAppStartersFactory ()

@end


@implementation BIAppStartersFactory

#pragma mark - Public

- (void)run {
    [MagicalRecord setupCoreDataStack];
}


@end
