//
//  BIAllCapitalsDatasource.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/16/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceFetchedCollectionView.h"

@interface BIAllCapitalsDatasource : BIDatasourceFetchedCollectionView

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
