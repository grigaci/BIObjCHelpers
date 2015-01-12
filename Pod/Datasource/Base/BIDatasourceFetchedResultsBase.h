//
//  BIDatasourceFetchedResultsBase.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/12/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

@import Foundation;
@import CoreData;

@interface BIDatasourceFetchedResultsBase : NSObject<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, assign, getter=isPaused) BOOL paused;

@end
