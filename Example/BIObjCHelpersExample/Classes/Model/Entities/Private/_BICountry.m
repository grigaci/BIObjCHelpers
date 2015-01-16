//
//  _BICountry.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/9/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "_BICountry.h"

const struct BICountryAttributes BICountryAttributes = {
    .name = @"name",
};

const struct BICountryRelationships BICountryRelationships = {
    .capital = @"capital",
};

@implementation _BICountry

@dynamic name;
@dynamic capital;

#pragma mark - BIModelBase methods

+ (NSString *)entityName {
    return @"BICountry";
}

@end
