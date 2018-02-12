//
//  BIMockCollectionViewDatasource.h
//  BIObjCHelpersTests
//
//  Created by Bogdan Iusco on 12/02/2018.
//  Copyright © 2018 iGama Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIMockCollectionViewDatasource : NSObject<UICollectionViewDataSource>

@property (nonatomic, copy, nullable, readwrite) NSInteger(^numberOfItemsInSectionCallback)(NSInteger);
@property (nonatomic, copy, nullable, readwrite) UICollectionViewCell *__nonnull(^cellForItemAtIndexPathCallback)(NSIndexPath *__nonnull);

@end
