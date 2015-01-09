//
//  _BIModelBase.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/9/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

@import CoreData;

extern const struct BIModelBaseAttributes {
    __unsafe_unretained NSString *createdat;
    __unsafe_unretained NSString *updatedat;
    __unsafe_unretained NSString *uuid;
} BIModelBaseAttributes;

@interface _BIModelBase : NSManagedObject

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc;
+ (NSString *)entityName;
+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)moc;

@property (nonatomic, strong) NSDate *createdat;
@property (nonatomic, strong) NSDate *updatedat;
@property (nonatomic, strong) NSString *uuid;

@end
