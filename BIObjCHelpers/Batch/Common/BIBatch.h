//
//  BITableViewBatch.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 14/07/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT const NSInteger kDefaultBatchSize;

typedef void(^BIBatchCompletionBlock)(NSError * __nullable error, NSArray * __nullable newIndexPaths);

@interface BIBatch : NSObject

/*!
 * @brief Designated initializer for a table view batch.
 * @param sectionIndex The index of the section where to fetch data.
 * @param batchSize The size of the batch to fetch.
 * @param completionBlock Code block to be called when fetching is done or in case of error.
 */
- (nonnull instancetype)initWithSection:(NSUInteger)sectionIndex
                              batchSize:(NSUInteger)batchSize
                        completionBlock:(nullable BIBatchCompletionBlock)completionBlock NS_DESIGNATED_INITIALIZER;

/*!
 * @brief Convenience kDefaultTableViewBatchSize for a table view batch.
 * @discussion Fetches kCardDefaultBatchSize elements in section index 0.
 * @param completionBlock Code block to be called when fetching is done or in case of error.
 */
- (nonnull instancetype)initWithCompletionBlock:(nullable BIBatchCompletionBlock)completionBlock;

/*!
 * @brief Size of the batch that is fetching.
 */
@property (nonatomic, assign, readonly) NSUInteger batchSize;

/*!
 * @brief Section index for which data is fetching.
 */
@property (nonatomic, assign, readonly) NSUInteger sectionIndex;

/*!
 * @brief Code block to be called when fetching is done or in case of error.
 */
@property (nonatomic, copy, nullable, readonly) BIBatchCompletionBlock completionBlock;

@end
