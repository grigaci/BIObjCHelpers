//
//  MockUICollectionView.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 6/16/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import "MockUICollectionView.h"

@implementation MockUICollectionView

#pragma mark - UICollectionView overriden methods

- (void)insertSections:(NSIndexSet *)sections {
    if (self.insertSectionsCallback) {
        self.insertSectionsCallback(sections);
    }
}

- (void)deleteSections:(NSIndexSet *)sections {
    if (self.deleteSectionsCallback) {
        self.deleteSectionsCallback(sections);
    }
}

- (void)reloadSections:(NSIndexSet *)sections {
    if (self.reloadSectionsCallback) {
        self.reloadSectionsCallback(sections);
    }
}

- (void)moveSection:(NSInteger)section toSection:(NSInteger)newSection {
    if (self.moveSectionCallback) {
        self.moveSectionCallback(section, newSection);
    }
}

- (void)insertItemsAtIndexPaths:(NSArray *)indexPaths {
    if (self.insertItemsCallback) {
        self.insertItemsCallback(indexPaths);
    }
}

- (void)deleteItemsAtIndexPaths:(NSArray *)indexPaths {
    if (self.deleteItemsCallback) {
        self.deleteItemsCallback(indexPaths);
    }
}

- (void)reloadItemsAtIndexPaths:(NSArray *)indexPaths {
    if (self.reloadItemsCallback) {
        self.reloadItemsCallback(indexPaths);
    }
}

- (void)moveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath {
    if (self.moveItemCallback) {
        self.moveItemCallback(indexPath, newIndexPath);
    }
}

- (void)reloadData {
    if (self.reloadDataCallback) {
        self.reloadDataCallback();
    }
}

- (UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    if (self.dequeueReusableCellWithReuseIdentifier) {
        return self.dequeueReusableCellWithReuseIdentifier(identifier, indexPath);
    }
    return [super dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

@end
