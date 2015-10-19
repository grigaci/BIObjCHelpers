//
//  BIBatchResponse.h
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 08/09/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BIBatchRequest;

@interface BIBatchResponse : NSObject

+ (nonnull instancetype)batchResponseForRequest:(nonnull BIBatchRequest *)batch
                                          error:(nullable NSError *)error
                                  newIndexPaths:(nullable NSArray *)newIndexPaths;

- (nonnull instancetype)initWithBatchRequest:(nonnull BIBatchRequest *)batch
                                       error:(nullable NSError *)error
                               newIndexPaths:(nullable NSArray *)newIndexPaths;

- (nonnull instancetype)init NS_UNAVAILABLE;
+ (nonnull instancetype)new NS_UNAVAILABLE;

@property (nonatomic, strong, nullable, readonly) NSError *error;
@property (nonatomic, copy,   nullable, readonly) NSArray *indexPaths;
@property (nonatomic, strong, nullable, readonly) BIBatchRequest *batchRequest;

@end

@interface BIBatchResponse (UITableView)

- (nonnull instancetype)initWithBatchRequest:(nonnull BIBatchRequest *)batch
                                   tableView:(nonnull UITableView *)tableView
                               countNewItems:(NSUInteger)countNewItems;

@end

@interface BIBatchResponse (UICollectionView)

- (nonnull instancetype)initWithBatchRequest:(nonnull BIBatchRequest *)batch
                              collectionView:(nonnull UICollectionView *)collectionView
                               countNewItems:(NSUInteger)countNewItems;

@end
