//
//  BITableViewBatch.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 14/07/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIBatch.h"

const NSInteger kDefaultBatchSize = 3;

@interface BIBatch ()

@property (nonatomic, assign, readwrite) NSUInteger batchSize;
@property (nonatomic, assign, readwrite) NSUInteger sectionIndex;
@property (nonatomic, copy, nullable, readwrite) BIBatchCompletionBlock completionBlock;

@end


@implementation BIBatch

#pragma mark - Init methods

- (instancetype)initWithSection:(NSUInteger)sectionIndex
                      batchSize:(NSUInteger)batchSize
                completionBlock:(BIBatchCompletionBlock)completionBlock {
    self = [super init];
    if (self) {
        self.sectionIndex = sectionIndex;
        self.batchSize = batchSize;
        self.completionBlock = completionBlock;
    }
    return self;
}

- (instancetype)initWithCompletionBlock:(BIBatchCompletionBlock)completionBlock {
    return [self initWithSection:0
                       batchSize:kDefaultBatchSize
                 completionBlock:completionBlock];
}

@end
