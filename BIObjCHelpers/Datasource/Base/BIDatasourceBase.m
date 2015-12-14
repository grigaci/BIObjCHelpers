//
//  BIDatasourceBase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 04/05/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceBase.h"

@interface BIDatasourceBase ()

@property (nonatomic, strong, nonnull, readwrite) NSHashTable *operations;

@end


@implementation BIDatasourceBase

#pragma mark - Property methods

- (NSHashTable *)operations {
    if (!_operations) {
        _operations = [NSHashTable weakObjectsHashTable];
    }
    return _operations;
}

@end
