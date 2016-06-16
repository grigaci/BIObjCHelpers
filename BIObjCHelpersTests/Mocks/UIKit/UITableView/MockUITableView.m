//
//  MockUITableView.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 6/16/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import "MockUITableView.h"

@implementation MockUITableView

- (nonnull instancetype)init {
    CGRect frame = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    return self;
}

#pragma mark - UITableView methods

- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier {
    [super registerNib:nib forCellReuseIdentifier:identifier];
    if (self.registerNibForCellReuseIdentifierCallback) {
        self.registerNibForCellReuseIdentifierCallback(nib, identifier);
    }
}

- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    [super registerClass:cellClass forCellReuseIdentifier:identifier];
    if (self.registerClassForCellReuseIdentifierCallback) {
        self.registerClassForCellReuseIdentifierCallback(cellClass, identifier);
    }
}

- (void)deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [super deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    if (self.deleteRowsAtIndexPathsWithRowAnimationCallback) {
        self.deleteRowsAtIndexPathsWithRowAnimationCallback(indexPaths, animation);
    }
}

- (void)insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [super insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    if (self.insertRowsAtIndexPathsWithRowAnimationCallback) {
        self.insertRowsAtIndexPathsWithRowAnimationCallback(indexPaths, animation);
    }
}

- (void)deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [super deleteSections:sections withRowAnimation:animation];
    if (self.deleteSectionsWithRowAnimationCallback) {
        self.deleteSectionsWithRowAnimationCallback(sections, animation);
    }
}

- (void)insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [super insertSections:sections withRowAnimation:animation];
    if (self.insertSectionsWithRowAnimationCallback) {
        self.insertSectionsWithRowAnimationCallback(sections, animation);
    }
}

@end
