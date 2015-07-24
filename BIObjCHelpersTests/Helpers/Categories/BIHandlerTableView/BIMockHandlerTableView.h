//
//  BIMockHandlerTableView.h
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 24/07/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BIHandlerTableView.h"

@interface BIMockHandlerTableView : BIHandlerTableView

@property (nonatomic, strong, nullable) void(^scrollViewWillEndDraggingCallback)(UIScrollView * __nonnull, CGPoint, CGPoint * __nonnull);

@end
