//
//  _BITableViewProxy.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 24/07/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "_BITableViewProxy.h"
#import "BITableView.h"

@interface _BITableViewProxy ()

@property (nonatomic, weak, nullable, readwrite) id target;
@property (nonatomic, weak, nullable, readwrite) BITableView *interceptor;

@end


@implementation _BITableViewProxy

- (nonnull instancetype)initWithTarget:(nullable id)target interceptor:(nonnull BITableView *)interceptor {
    self.target = target;
    self.interceptor = interceptor;

    return self;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    NSParameterAssert(self.interceptor);

    BOOL responds = [self.interceptor respondsToSelector:aSelector] || [self.target respondsToSelector:aSelector];
    return responds;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSParameterAssert(self.interceptor);
  
    if ([self.interceptor respondsToSelector:aSelector]) {
        return self.interceptor;
    }

    return [self.target respondsToSelector:aSelector] ? self.target : nil;
}

@end
