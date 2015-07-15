//
//  BIAllCapitalsCollectionViewController.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/13/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIAllCapitalsCollectionViewController.h"
#import "BIAllCapitalsDatasource.h"

#import <MagicalRecord/MagicalRecord.h>

@interface BIAllCapitalsCollectionViewController ()

@property (nonatomic, nullable, strong) BIAllCapitalsDatasource *datasource;

@end

@implementation BIAllCapitalsCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datasource = [BIAllCapitalsDatasource datasourceWithCollectionView:self.collectionView];
    self.datasource.managedObjectContext = [NSManagedObjectContext MR_defaultContext];
    [self.datasource load];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    layout.estimatedItemSize = CGSizeMake(100.f, 50.f);
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.collectionViewLayout invalidateLayout];
}

@end
