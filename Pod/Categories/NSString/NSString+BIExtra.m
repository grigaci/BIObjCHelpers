//
//  NSString+BIExtra.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 18/06/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "NSString+BIExtra.h"

@implementation NSString (BIExtra)

+ (nonnull instancetype)randomString {
    NSUInteger length = arc4random() % 10 + 1;
    return [[self class] randomStringOfLength:length];
}

+ (nonnull instancetype)randomStringOfLength:(NSUInteger)length {
    static NSString *alphabet  = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
    NSMutableString *s = [NSMutableString stringWithCapacity:20];
    for (NSUInteger i = 0U; i < length; i++) {
        u_int32_t r = arc4random() % [alphabet length];
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    return [NSString stringWithString:s];
}

@end
