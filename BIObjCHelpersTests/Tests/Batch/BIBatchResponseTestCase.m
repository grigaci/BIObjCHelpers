//
//  BIBatchResponseTestCase.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 08/09/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

// App target
#import "BIBatchResponse.h"
#import "BIBatchRequest.h"
#import "NSString+BIExtra.h"

// Frameworks, libs
#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface BIBatchResponseTestCase : XCTestCase

@end

@implementation BIBatchResponseTestCase

#pragma mark - Setup methods

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark - Test Inits

- (void)test_inits {
    BIBatchRequest *batchRequest = [[BIBatchRequest alloc] initWithCompletionBlock:nil];
    BIMutableBatchResponse *mutableBatchReponse = [BIMutableBatchResponse batchResponseForRequest:batchRequest];
    XCTAssertNotNil(mutableBatchReponse);
    XCTAssertEqual(mutableBatchReponse.batchRequest, batchRequest);
}

@end
