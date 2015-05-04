//
//  BIHandlerTableView.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 04/05/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIHandlerTableView.h"

@interface BIHandlerTableView ()

@property (nonatomic, readwrite, strong) UITableView *tableView;

@end


@implementation BIHandlerTableView

#pragma mark - Init methods

+ (instancetype)handlerWithTableView:(UITableView *)tableView {
    return [[[self class] alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    NSParameterAssert(tableView);
    self = [super init];
    if (self) {
        self.tableView = tableView;
    }
    return self;
}

#pragma mark - BILifecycle methods

- (void)load {
    [super load];
    self.tableView.delegate = self;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didSelectRowCallback) {
        id cell = [self.tableView cellForRowAtIndexPath:indexPath];
        self.didSelectRowCallback(cell, indexPath);
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didDeselectRowCallback) {
        id cell = [self.tableView cellForRowAtIndexPath:indexPath];
        self.didDeselectRowCallback(cell, indexPath);
    }
}

@end
