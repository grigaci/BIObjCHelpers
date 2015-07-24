//
//  _BITableViewProxy.h
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 24/07/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BITableView;

@interface _BITableViewProxy : NSProxy

- (nonnull instancetype)initWithTarget:(nullable id<NSObject>)target interceptor:(nonnull BITableView *)interceptor;

@property (nonatomic, weak, nullable, readonly) id target;
@property (nonatomic, weak, nullable, readonly) BITableView *interceptor;


@end
