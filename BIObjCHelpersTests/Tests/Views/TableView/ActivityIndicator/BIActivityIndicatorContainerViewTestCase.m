//
//  BIActivityIndicatorContainerViewTestCase.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 08/09/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

// App target
#import "BIActivityIndicatorContainerView.h"

// Frameworks, libraries
#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

@interface BIActivityIndicatorContainerViewTestCase : FBSnapshotTestCase

@end

@implementation BIActivityIndicatorContainerViewTestCase

#pragma mark - Setup methods

- (void)setUp {
    [super setUp];
//    self.recordMode = YES;
}

#pragma mark - Snapshot tests

- (void)testSnapshotView375x44 {
    CGRect frame = CGRectMake(.0f, .0f, 375.f, 44.f);
    BIActivityIndicatorContainerView *view = [[BIActivityIndicatorContainerView alloc] initWithFrame:frame];
    FBSnapshotVerifyViewWithOptions(view, nil, FBSnapshotTestCaseDefaultSuffixes(), 0);
}

@end
