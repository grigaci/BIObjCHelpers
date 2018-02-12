//
//  BIMockCollectionViewDatasource.m
//  BIObjCHelpersTests
//
//  Created by Bogdan Iusco on 12/02/2018.
//  Copyright © 2018 iGama Apps. All rights reserved.
//

#import "BIMockCollectionViewDatasource.h"

@implementation BIMockCollectionViewDatasource

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.numberOfItemsInSectionCallback) {
        return self.numberOfItemsInSectionCallback(section);
    }
    return 0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cellForItemAtIndexPathCallback) {
        return self.cellForItemAtIndexPathCallback(indexPath);
    }
    return [[UICollectionViewCell alloc] init];
}

@end
