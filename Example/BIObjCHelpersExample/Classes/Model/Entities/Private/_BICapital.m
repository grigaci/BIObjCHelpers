//
//  _BICapital.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/9/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "_BICapital.h"

const struct BICapitalAttributes BICapitalAttributes = {
    .name = @"name",
};

const struct BICapitalRelationships BICapitalRelationships = {
    .country = @"country",
};

@implementation _BICapital

@dynamic name;
@dynamic country;

#pragma mark - BIModelBase methods

+ (NSString *)entityName {
    return @"BICapital";
}

@end
