//
//  BIMockDatasourceFeedTableView.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 14/07/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceFeedTableView.h"

@interface BIMockDatasourceFeedTableView : BIDatasourceFeedTableView

@property (nonatomic, strong, nullable) BIBatch *__nonnull(^createNextBatchCallback)();
@property (nonatomic, copy, nullable) void(^fetchBatchCallback)(BIBatch * __nonnull);
@property (nonatomic, strong, nullable) void(^fetchBatchCompletedWithFailureCallback)(NSError * __nonnull);
@property (nonatomic, strong, nullable) void(^fetchBatchCompletedWithSuccessCallback)(NSArray * __nonnull);

@end
