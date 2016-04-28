//
//  BIObjCHelpers.h
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 4/27/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for BIObjCHelpers.
FOUNDATION_EXPORT double BIObjCHelpersVersionNumber;

//! Project version string for BIObjCHelpers.
FOUNDATION_EXPORT const unsigned char BIObjCHelpersVersionString[];

#import <BIObjCHelpers/BIStarterProtocol.h>
#import <BIObjCHelpers/BILifecycle.h>
#import <BIObjCHelpers/BIStartersFactory.h>
#import <BIObjCHelpers/BIOperationQueue.h>
#import <BIObjCHelpers/BILaunchStartersFactory.h>

// Views
#import <BIObjCHelpers/BITableView.h>
#import <BIObjCHelpers/BIScrollAdditionalViewBase.h>
#import <BIObjCHelpers/BIScrollAdditionalLoadingView.h>
#import <BIObjCHelpers/BIScrollAdditionalNoContentView.h>
#import <BIObjCHelpers/BIScrollAdditionalErrorNoContentView.h>
#import <BIObjCHelpers/BICollectionView.h>
#import <BIObjCHelpers/UIScrollView+BIBatching.h>

// Datasources
#import <BIObjCHelpers/BIDatasourceTableView.h>
#import <BIObjCHelpers/BIDatasourceCollectionView.h>
#import <BIObjCHelpers/BIDatasourceFetchedTableView.h>
#import <BIObjCHelpers/BIDatasourceFetchedCollectionView.h>
#import <BIObjCHelpers/BIDatasourceFeedTableView.h>

// Handlers
#import <BIObjCHelpers/BIHandlerBase.h>
#import <BIObjCHelpers/BIHandlerTableView.h>

// Categories
#import <BIObjCHelpers/NSBundle+BIExtra.h>
#import <BIObjCHelpers/NSString+BIExtra.h>
#import <BIObjCHelpers/NSDate+BIAttributedString.h>

// Batch
#import <BIObjCHelpers/BIBatchRequest.h>
#import <BIObjCHelpers/BIBatchResponse.h>
