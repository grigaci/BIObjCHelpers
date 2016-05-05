//
//  BITableViewCellTestCase.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 08/09/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

// App target
#import "BITableViewCell.h"

// Frameworks, libraries
#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

@interface BITableViewCellTestCase : FBSnapshotTestCase

@property (nonatomic, strong, nullable) BITableViewCell *cell;

@end

@implementation BITableViewCellTestCase

#pragma mark - Setup methods

- (void)setUp {
    [super setUp];
    self.cell = [[BITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    self.cell.frame = CGRectMake(.0f, .0f, 375.f, 44.f);
    self.cell.backgroundColor = [UIColor whiteColor];
//    self.recordMode = YES;
}

- (void)tearDown {
    [super tearDown];
    self.cell = nil;
}

#pragma mark - Snapshot tests

- (void)testSnapshotViewDefault375x44 {
    self.cell.frame = CGRectMake(.0f, .0f, 375.f, 44.f);
    FBSnapshotVerifyViewWithOptions(self.cell, nil, FBSnapshotTestCaseDefaultSuffixes(), 0);
}


- (void)testSnapshotViewSeparator375x44 {
    self.cell.frame = CGRectMake(.0f, .0f, 375.f, 44.f);
    self.cell.separatorViewVisible = YES;
    FBSnapshotVerifyViewWithOptions(self.cell, nil, FBSnapshotTestCaseDefaultSuffixes(), 0);
}

- (void)testSnapshotViewSeparatorCustomHeight375x44 {
    self.cell.frame = CGRectMake(.0f, .0f, 375.f, 44.f);
    self.cell.separatorViewVisible = YES;
    self.cell.separatorViewHeight = 4.f;
    self.cell.separatorView.backgroundColor = [UIColor purpleColor];
    FBSnapshotVerifyViewWithOptions(self.cell, nil, FBSnapshotTestCaseDefaultSuffixes(), 0);
}

@end
