//
//  BIBatchResponse.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 08/09/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BIBatchResponse.h"
#import "BIBatchRequest.h"

@interface BIBatchResponse ()

@property (nonatomic, strong, nullable, readwrite) NSError *error;
@property (nonatomic, copy,   nullable, readwrite) NSArray *indexPaths;
@property (nonatomic, strong, nullable, readwrite) BIBatchRequest *batchRequest;

@end

@implementation BIBatchResponse

#pragma mark - Factory methods

+ (nonnull instancetype)batchResponseForRequest:(nonnull BIBatchRequest *)batch
                                          error:(nullable NSError *)error
                                  newIndexPaths:(nullable NSArray *)newIndexPaths {
    return [[self alloc] initWithBatchRequest:batch
                                        error:error
                                newIndexPaths:newIndexPaths];
}

#pragma mark - Init methods

- (nonnull instancetype)initWithBatchRequest:(nonnull BIBatchRequest *)batch
                                       error:(nullable NSError *)error
                               newIndexPaths:(nullable NSArray *)newIndexPaths {
    self = [super init];
    if (self) {
        self.batchRequest = batch;
        self.error = error;
        self.indexPaths = newIndexPaths;
    }
    return self;
}

- (nonnull instancetype)initWithBatchRequest:(nonnull BIBatchRequest *)batchRequest
                                   tableView:(nonnull UITableView *)tableView
                               countNewItems:(NSUInteger)countNewItems {
    NSUInteger sectionIndex = batchRequest.sectionIndex;
    NSUInteger countSectionItems = [tableView numberOfRowsInSection:sectionIndex];
    self = [self initWithBatchRequest:batchRequest
                    countSectionItems:countSectionItems
                        countNewItems:countNewItems];
    return self;
}

- (nonnull instancetype)initWithBatchRequest:(nonnull BIBatchRequest *)batchRequest
                              collectionView:(nonnull UICollectionView *)collectionView
                               countNewItems:(NSUInteger)countNewItems {
    NSUInteger sectionIndex = batchRequest.sectionIndex;
    NSUInteger countSectionItems = [collectionView numberOfItemsInSection:sectionIndex];
    self = [self initWithBatchRequest:batchRequest
                    countSectionItems:countSectionItems
                        countNewItems:countNewItems];
    return self;
}

- (nonnull instancetype)initWithBatchRequest:(nonnull BIBatchRequest *)batchRequest
                           countSectionItems:(NSUInteger)countSectionItems
                               countNewItems:(NSUInteger)countNewItems {
    NSUInteger sectionIndex = batchRequest.sectionIndex;
    NSUInteger newRowIndex = 0;
    switch (batchRequest.insertPosition) {
        case BIBatchInsertPositionTop:
            newRowIndex = 0;
            break;
        case BIBatchInsertPositionBottom:
            newRowIndex = countSectionItems;
            break;
        default:
            newRowIndex = batchRequest.insertPosition;
            break;
    }
    
    NSUInteger lastRowIndex = newRowIndex + countNewItems;
    NSMutableArray *mutableArray = [NSMutableArray new];
    for (NSUInteger index = newRowIndex; index < lastRowIndex; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:sectionIndex];
        [mutableArray addObject:indexPath];
    }
    
    self = [self initWithBatchRequest:batchRequest
                                error:nil
                        newIndexPaths:[mutableArray copy]];
    
    return self;
}

@end

