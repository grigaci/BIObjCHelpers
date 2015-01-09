//
//  _BIModelBase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/9/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "_BIModelBase.h"

const struct BIModelBaseAttributes BIModelBaseAttributes = {
    .createdat = @"createdat",
    .updatedat = @"updatedat",
    .uuid = @"uuid",
};

@implementation _BIModelBase

@dynamic createdat;
@dynamic updatedat;
@dynamic uuid;

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext*)moc {
    NSParameterAssert(moc);
    NSString *entityName = [[self class] entityName];
    _BIModelBase *object = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:moc];
    
    object.uuid = [NSUUID UUID].UUIDString;
    
    NSDate *date = [NSDate date];
    object.createdat = date;
    object.updatedat = date;

    return object;
}

+ (NSString *)entityName {
    // Core Data model doesn't have this entity.
    NSAssert(false, @"Base class! Please use inherited classes.");
    return nil;
}

+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext*)moc {
    NSParameterAssert(moc);
    NSString *entityName = [[self class] entityName];
    return [NSEntityDescription entityForName:entityName inManagedObjectContext:moc];
}

@end
