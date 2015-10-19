//
//  BIBatchRequest.h
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 08/09/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT const NSInteger kDefaultBatchRequestSize;

@class BIBatchResponse;

typedef void(^BIBatchRequestCompletionBlock)(BIBatchResponse * __nonnull response);

/*!
 @brief Helper values for batch insert position.
 */
typedef NS_ENUM(NSUInteger, BIBatchInsertPosition) {
    /*!
     * @brief insert new elements at the beggining.
     */
    BIBatchInsertPositionTop = 0,
    /*!
     * @brief insert new elements at the end.
     */
    BIBatchInsertPositionBottom = UINT_MAX
};

/*!
 * @brief Defines a set of data request values.
 * Mostly used in table and collection views for inserting sets of data.
 */
@interface BIBatchRequest : NSObject

- (nonnull instancetype)init NS_UNAVAILABLE;
+ (nonnull instancetype)new NS_UNAVAILABLE;

/*!
 * @brief Designated initializer for a table view batch.
 * @param sectionIndex The index of the section where to fetch data.
 * @param batchSize The size of the batch to fetch.
 * @param completionBlock Code block to be called when fetching is done or in case of error.
 */
- (nonnull instancetype)initWithSection:(NSUInteger)sectionIndex
                              batchSize:(NSUInteger)batchSize
                        completionBlock:(nullable BIBatchRequestCompletionBlock)completionBlock NS_DESIGNATED_INITIALIZER;

/*!
 * @brief Convenience kDefaultTableViewBatchSize for a table view batch.
 * @discussion Fetches kCardDefaultBatchSize elements in section index 0.
 * @param completionBlock Code block to be called when fetching is done or in case of error.
 */
- (nonnull instancetype)initWithCompletionBlock:(nullable BIBatchRequestCompletionBlock)completionBlock;

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
@property (nonatomic, copy, nullable, readonly) BIBatchRequestCompletionBlock completionBlock;

/*!
 * @brief Specify an index from where to start inserting the new elements that will be fetched.
 * Defaults to BIBatchInsertPositionBottom;
 */
@property (nonatomic, assign) NSUInteger insertPosition;

@end
