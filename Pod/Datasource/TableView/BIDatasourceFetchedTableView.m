//
//  BIDatasourceFetchedTableView.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/12/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceFetchedTableView.h"

@interface BIDatasourceFetchedTableView ()

@property (nonatomic, readwrite, strong) UITableView *tableView;

@end

@implementation BIDatasourceFetchedTableView

#pragma mark - Init methods

+ (instancetype)datasourceWithTableView:(UITableView *)tableView {
    return [[[self class] alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    NSParameterAssert(tableView);
    self = [super init];
    if (self) {
        self.tableView = tableView;
        self.tableView.dataSource = self;
    }
    return self;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if (self.configureCellBlock) {
        self.configureCellBlock(cell, indexPath);
    }
}

- (void)load {
    NSParameterAssert(self.fetchedResultsController);
    [self.tableView registerClass:self.cellClass forCellReuseIdentifier:self.cellIdentifier];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSParameterAssert(self.fetchedResultsController);
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSParameterAssert(self.fetchedResultsController);
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSParameterAssert(self.fetchedResultsController);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath: indexPath];
    if (!cell) {
        cell = [[self.cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
    }
    [self configureCell: cell atIndexPath: indexPath];

    return cell;
}

#pragma mark - NSFetchedResultsControllerDelegate Methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections: [NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation: UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections: [NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation: UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
        case NSFetchedResultsChangeUpdate:
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch(type) {
            // Data was inserted -- insert the data into the table view
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            // Data was deleted -- delete the data from the table view
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
            break;
            // Data was updated (changed) -- reconfigure the cell for the data
        case NSFetchedResultsChangeUpdate:
            
            [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath: indexPath];
            break;
            // Data was moved -- delete the data from the old location and insert the data into the new location
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            
            NSArray *insertPaths = @[newIndexPath];
            
            [self.tableView insertRowsAtIndexPaths:insertPaths withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

#pragma mark - property methods

- (NSString *)cellIdentifier {
    if (!_cellIdentifier) {
        _cellIdentifier = [NSUUID UUID].UUIDString;
    }
    return _cellIdentifier;
}

- (Class)cellClass {
    if (!_cellClass) {
        _cellClass = [UITableViewCell class];
    }
    return _cellClass;
}

@end
