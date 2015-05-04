//
//  BIDatasourceBase+Private.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 04/05/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceBase.h"

@interface BIDatasourceBase (Private)

@property (nonatomic, assign, readwrite, getter=isLoaded) BOOL loaded;

@end
