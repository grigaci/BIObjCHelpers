//
//  MockNSFetchedResultsSectionInfo.h
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 6/16/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface MockNSFetchedResultsSectionInfo : NSObject<NSFetchedResultsSectionInfo>

@property (nonatomic, strong, nullable, readwrite) NSString *name;
@property (nonatomic, strong, nullable, readwrite) NSString *indexTitle;
@property (nonatomic, assign, readwrite) NSUInteger numberOfObjects;
@property (nonatomic, strong, nullable, readwrite) NSArray *objects;

@end
