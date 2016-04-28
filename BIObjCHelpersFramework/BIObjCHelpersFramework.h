//
//  BIObjCHelpersFramework.h
//  BIObjCHelpersFramework
//
//  Created by Bogdan Iusco on 4/27/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for BIObjCHelpersFramework.
FOUNDATION_EXPORT double BIObjCHelpersFrameworkVersionNumber;

//! Project version string for BIObjCHelpersFramework.
FOUNDATION_EXPORT const unsigned char BIObjCHelpersFrameworkVersionString[];

#import <BIObjCHelpersFramework/BIStarterProtocol.h>
#import <BIObjCHelpersFramework/BILifecycle.h>
#import <BIObjCHelpersFramework/BIStartersFactory.h>
#import <BIObjCHelpersFramework/BIOperationQueue.h>
#import <BIObjCHelpersFramework/BILaunchStartersFactory.h>

// Views
#import <BIObjCHelpersFramework/BITableView.h>
#import <BIObjCHelpersFramework/BIScrollAdditionalViewBase.h>
#import <BIObjCHelpersFramework/BIScrollAdditionalLoadingView.h>
#import <BIObjCHelpersFramework/BIScrollAdditionalNoContentView.h>
#import <BIObjCHelpersFramework/BIScrollAdditionalErrorNoContentView.h>
#import <BIObjCHelpersFramework/BICollectionView.h>
#import <BIObjCHelpersFramework/UIScrollView+BIBatching.h>

// Datasources
#import <BIObjCHelpersFramework/BIDatasourceTableView.h>
#import <BIObjCHelpersFramework/BIDatasourceCollectionView.h>
#import <BIObjCHelpersFramework/BIDatasourceFetchedTableView.h>
#import <BIObjCHelpersFramework/BIDatasourceFetchedCollectionView.h>
#import <BIObjCHelpersFramework/BIDatasourceFeedTableView.h>

// Handlers
#import <BIObjCHelpersFramework/BIHandlerBase.h>
#import <BIObjCHelpersFramework/BIHandlerTableView.h>

// Categories
#import <BIObjCHelpersFramework/NSBundle+BIExtra.h>
#import <BIObjCHelpersFramework/NSString+BIExtra.h>
#import <BIObjCHelpersFramework/NSDate+BIAttributedString.h>

// Batch
#import <BIObjCHelpersFramework/BIBatchRequest.h>
#import <BIObjCHelpersFramework/BIBatchResponse.h>
