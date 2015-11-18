//
//  BIDatasourceBase.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 04/05/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BILifecycle.h"

@interface BIDatasourceBase : BILifecycle

@property (nonatomic, strong, nonnull, readonly) NSHashTable *operations;

@end
