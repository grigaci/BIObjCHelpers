//
//  BIBatchRequest.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 08/09/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BIBatchRequest.h"

const NSInteger kDefaultBatchRequestSize = 3;

@interface BIBatchRequest ()

@property (nonatomic, assign, readwrite) NSUInteger batchSize;
@property (nonatomic, assign, readwrite) NSUInteger sectionIndex;
@property (nonatomic, copy, nullable, readwrite) BIBatchRequestCompletionBlock completionBlock;

@end


@implementation BIBatchRequest

#pragma mark - Init methods

- (instancetype)initWithSection:(NSUInteger)sectionIndex
                      batchSize:(NSUInteger)batchSize
                completionBlock:(BIBatchRequestCompletionBlock)completionBlock {
    self = [super init];
    if (self) {
        self.sectionIndex = sectionIndex;
        self.batchSize = batchSize;
        self.completionBlock = completionBlock;
        self.insertPosition = BIBatchInsertPositionBottom;
    }
    return self;
}

- (instancetype)initWithCompletionBlock:(BIBatchRequestCompletionBlock)completionBlock {
    return [self initWithSection:0
                       batchSize:kDefaultBatchRequestSize
                 completionBlock:completionBlock];
}

@end
