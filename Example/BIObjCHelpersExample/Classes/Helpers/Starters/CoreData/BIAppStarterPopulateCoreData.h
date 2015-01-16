//
//  BIAppStarterPopulateCoreData.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/13/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

@import Foundation;
@import CoreData;

#import "BIStarterProtocol.h"

extern const struct BIAppStarterPopulateCoreDataPlistKeys {
    __unsafe_unretained NSString *country;
    __unsafe_unretained NSString *capital;
} BIAppStarterPopulateCoreDataPlistKeys;


@interface BIAppStarterPopulateCoreData : NSObject <BIStarter>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
