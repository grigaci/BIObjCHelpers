//
//  BITableViewBatch.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 14/07/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BITableViewBatch.h"

const NSInteger kDefaultTableViewBatchSize = 10;

@interface BITableViewBatch ()

@property (nonatomic, assign, readwrite) NSUInteger batchSize;
@property (nonatomic, assign, readwrite) NSUInteger sectionIndex;
@property (nonatomic, copy, nullable, readwrite) BITableViewBatchCompletionBlock completionBlock;

@end


@implementation BITableViewBatch

#pragma mark - Init methods

- (instancetype)initWithSection:(NSUInteger)sectionIndex
                      batchSize:(NSUInteger)batchSize
                completionBlock:(BITableViewBatchCompletionBlock)completionBlock {
    self = [super init];
    if (self) {
        self.sectionIndex = sectionIndex;
        self.batchSize = batchSize;
        self.completionBlock = completionBlock;
    }
    return self;
}

- (instancetype)initWithCompletionBlock:(BITableViewBatchCompletionBlock)completionBlock {
    return [self initWithSection:0
                       batchSize:kDefaultTableViewBatchSize
                 completionBlock:completionBlock];
}

@end
