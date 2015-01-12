//
//  BIDatasourceFetchedResultsBase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/12/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceFetchedResultsBase.h"

@implementation BIDatasourceFetchedResultsBase

#pragma mark - Public methods


#pragma mark - Property methods

- (void)setFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController {
    NSParameterAssert(fetchedResultsController);
    if (_fetchedResultsController) {
        _fetchedResultsController.delegate = nil;
    }

    _fetchedResultsController = fetchedResultsController;
    _fetchedResultsController.delegate = self;
}

- (void)setPaused:(BOOL)paused {
    self.fetchedResultsController.delegate = paused? nil : self;
    _paused = paused;
    if (!_paused) {
        NSError *error;
        [self.fetchedResultsController performFetch:&error];
        if (error) {
            NSLog(@"Error while performing fetch: %@", error);
        }
    }
}

@end
