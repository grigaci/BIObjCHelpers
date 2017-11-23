//
//  BIMockDatasourceFeedTableView.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 14/07/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceFeedTableView.h"

@interface BIMockDatasourceFeedTableView : BIDatasourceFeedTableView

@property (nonatomic, strong, nullable) BIBatchRequest *__nonnull(^createNextBatchCallback)(void);
@property (nonatomic, copy, nullable) void(^fetchBatchCallback)(BIBatchRequest * __nonnull);
@property (nonatomic, strong, nullable) void(^handleFetchBatchResponseWithFailureCallback)(BIBatchResponse * __nonnull);
@property (nonatomic, strong, nullable) void(^handleFetchBatchResponseWithSuccessCallback)(BIBatchResponse * __nonnull);

@end
