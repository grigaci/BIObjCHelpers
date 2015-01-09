//
//  _BICapital.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/9/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIModelBase.h"

extern const struct BICapitalAttributes {
    __unsafe_unretained NSString *name;
} BICapitalAttributes;

extern const struct BICapitalRelationships {
    __unsafe_unretained NSString *country;
} BICapitalRelationships;

@class BICountry;

@interface _BICapital : BIModelBase

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) BICountry *country;

@end
