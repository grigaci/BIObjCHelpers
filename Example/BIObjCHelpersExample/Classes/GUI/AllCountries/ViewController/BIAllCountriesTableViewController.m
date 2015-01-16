//
//  BIAllCountriesTableViewController.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/2/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "BIAllCountriesTableViewController.h"
#import "BIAllCountriesDatasource.h"

@interface BIAllCountriesTableViewController ()

@property (nonatomic, strong) BIAllCountriesDatasource *datasource;

@end

@implementation BIAllCountriesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datasource = [BIAllCountriesDatasource datasourceWithTableView:self.tableView];
    self.datasource.managedObjectContext = [NSManagedObjectContext MR_defaultContext];
    [self.datasource load];
}


@end
