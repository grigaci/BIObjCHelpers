//
//  BIExampleFeedCollectionViewController.m
//  BIObjCHelpersExample
//
//  Created by Mihai Chifor on 8/31/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIExampleFeedCollectionViewController.h"
#import "BIExampleDatasourceFeedCollectionView.h"

#import <BIObjCHelpers/BICollectionView.h>
#import <BIObjCHelpers/BIHandlerCollectionView.h>

@interface BIExampleFeedCollectionViewController ()

@property (nonatomic, strong) BIExampleDatasourceFeedCollectionView *dataSource;
@property (nonatomic, strong) BIHandlerCollectionView *handler;

@end

@implementation BIExampleFeedCollectionViewController

#pragma mark - Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.dataSource load];
    [self.handler load];
}

#pragma mark - Properties

- (BIExampleDatasourceFeedCollectionView *)dataSource {
    if (!_dataSource) {
        _dataSource = [BIExampleDatasourceFeedCollectionView datasourceWithBICollectionView:self.biCollectionView];
    }
    return _dataSource;
}

- (BIHandlerCollectionView *)handler {
    if (!_handler) {
        _handler = [BIHandlerCollectionView handlerWithCollectionView:self.biCollectionView];
    }
    return _handler;
}

@end
