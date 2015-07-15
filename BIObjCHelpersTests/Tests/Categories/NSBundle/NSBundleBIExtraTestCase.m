//
//  NSBundleBIExtraTestCase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 18/06/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "NSString+BIExtra.h"
#import "NSBundle+BIExtra.h"

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@interface NSBundleBIExtraTestCase : XCTestCase

@end

@implementation NSBundleBIExtraTestCase

- (void)testValidPath {
    NSString *filename = @"DefaultData.plist";
    NSString *fullpath = [[NSBundle bundleForClass:[self class]] fullPathForFilename:filename];
    XCTAssertTrue(fullpath.length);
}

- (void)testInvalidPath {
    NSString *filename = [NSString stringWithFormat:@"%@.%@", [NSString randomString], [NSString randomStringOfLength:2]];
    NSString *fullpath = [[NSBundle bundleForClass:[self class]] fullPathForFilename:filename];
    XCTAssertFalse(fullpath.length);
}

@end
