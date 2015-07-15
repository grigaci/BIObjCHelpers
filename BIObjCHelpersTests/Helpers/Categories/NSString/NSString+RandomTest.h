//
//  NSString+RandomTest.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/9/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RandomTest)

+ (instancetype)randomString;
+ (instancetype)randomStringOfLength:(NSUInteger)length;

@end
