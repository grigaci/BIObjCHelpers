//
//  NSStringBIExtraTestCase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 18/06/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "NSString+BIExtra.h"

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@interface NSStringBIExtraTestCase : XCTestCase

@end

@implementation NSStringBIExtraTestCase

- (void)testRandomString {
    NSString *randomString1 = [NSString randomString];
    NSString *randomStrong2 = [NSString randomString];
    XCTAssertFalse([randomString1 isEqualToString:randomStrong2]);
}

- (void)testRandomStringOfLength {
    const NSUInteger counter = 10;
    for (NSUInteger index = 0; index < counter; index++) {
        NSString *testedString = [NSString randomStringOfLength:index];
        XCTAssertEqual(testedString.length, index);
    }
}

@end
