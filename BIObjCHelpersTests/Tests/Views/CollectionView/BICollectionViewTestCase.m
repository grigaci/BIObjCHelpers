//
//  BICollectionViewTestCase.m
//  BIObjCHelpersTests
//
//  Created by Bogdan Iusco on 12/02/2018.
//  Copyright © 2018 iGama Apps. All rights reserved.
//

#import "BICollectionView.h"
#import "BIScrollAdditionalViewBase.h"
#import "UIScrollView+BIBatching.h"
#import "BIMockCollectionViewDatasource.h"

#import <XCTest/XCTest.h>

@interface BICollectionViewTestCase : XCTestCase

@property (nonatomic, strong, nullable) BICollectionView *collectionView;
@property (nonatomic, strong, nullable) UICollectionViewLayout *layout;
@property (nonatomic, strong, nullable) BIMockCollectionViewDatasource *datasource;

@end

@implementation BICollectionViewTestCase

- (void)setUp {
    [super setUp];
    CGRect frame = CGRectMake(0, 0, 100, 100);
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[BICollectionView alloc] initWithFrame:frame collectionViewLayout:self.layout];
    self.datasource = [[BIMockCollectionViewDatasource alloc] init];
    self.datasource.numberOfItemsInSectionCallback = ^NSInteger(NSInteger section) {
        return 1;
    };
    self.collectionView.dataSource = self.datasource;
}

#pragma mark - Test reloadData

- (void)test_reloadData_no_content {
    BIScrollAdditionalViewBase *noContentView = [[BIScrollAdditionalViewBase alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.collectionView.createAdditionalNoContentViewCallback = ^BIScrollAdditionalViewBase * _Nullable{
        return noContentView;
    };
    [self.collectionView addAdditionalNoContentView];
    XCTAssertNotNil(noContentView.superview);
    
    [self.collectionView reloadData];
    
    XCTAssertNil(noContentView.superview);
}

- (void)test_reloadData_loading {
    BIScrollAdditionalViewBase *loadingView = [[BIScrollAdditionalViewBase alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.collectionView.createAdditionalLoadingContentViewCallback = ^BIScrollAdditionalViewBase * _Nullable{
        return loadingView;
    };
    [self.collectionView addAdditionalLoadingContentView];
    XCTAssertNotNil(loadingView.superview);
    
    [self.collectionView reloadData];
    
    XCTAssertNil(loadingView.superview);
}

@end
