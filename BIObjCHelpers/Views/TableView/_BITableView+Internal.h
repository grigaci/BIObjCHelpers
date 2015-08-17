//
//  BITableView+Internal.h
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 17/08/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BITableView.h"

@interface BITableView (Internal)

@property (nonatomic, weak, nullable, readwrite) BIDatasourceTableView *datasource;
@property (nonatomic, weak, nullable, readwrite) BIHandlerTableView *handler;

@end