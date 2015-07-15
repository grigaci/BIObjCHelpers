//
//  BITestCaseCoreData.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/9/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <XCTest/XCTest.h>

@interface BITestCaseCoreData : XCTestCase

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
