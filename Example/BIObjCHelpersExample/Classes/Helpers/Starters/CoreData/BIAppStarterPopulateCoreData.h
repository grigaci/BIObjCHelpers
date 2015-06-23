//
//  BIAppStarterPopulateCoreData.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/13/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIStarterProtocol.h"

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

extern const struct BIAppStarterPopulateCoreDataPlistKeys {
    __unsafe_unretained NSString * __nonnull country;
    __unsafe_unretained NSString * __nonnull capital;
} BIAppStarterPopulateCoreDataPlistKeys;


@interface BIAppStarterPopulateCoreData : NSObject <BIStarter>

@property (nonatomic, nullable, strong) NSManagedObjectContext *managedObjectContext;

@end
