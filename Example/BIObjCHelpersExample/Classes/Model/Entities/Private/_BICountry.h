//
//  _BICountry.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/9/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIModelBase.h"

extern const struct BICountryAttributes {
    __unsafe_unretained NSString *name;
} BICountryAttributes;

extern const struct BICountryRelationships {
    __unsafe_unretained NSString *capital;
} BICountryRelationships;

@class BICapital;

@interface _BICountry : BIModelBase

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) BICapital *capital;

@end
