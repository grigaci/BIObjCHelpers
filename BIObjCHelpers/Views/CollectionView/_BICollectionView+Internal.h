//
//  BICollectionView+Internal.h
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 8/31/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BICollectionView.h"

@interface BICollectionView (Internal)

@property (nonatomic, weak, nullable, readwrite) BIDatasourceCollectionView *datasource;
@property (nonatomic, weak, nullable, readwrite) BIHandlerCollectionView *handler;

@end
