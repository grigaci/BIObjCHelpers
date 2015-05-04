//
//  BIHandlerTableView.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 04/05/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIHandlerBase.h"

@import UIKit;

typedef void(^BIHandlerTableViewRowSelectionCallback)(id cell, NSIndexPath *indexPath);

@interface BIHandlerTableView : BIHandlerBase<UITableViewDelegate>

+ (instancetype)handlerWithTableView:(UITableView *)tableView;
- (instancetype)initWithTableView:(UITableView *)tableView;

@property (nonatomic, readonly, strong) UITableView *tableView;

@property (nonatomic, copy) BIHandlerTableViewRowSelectionCallback didSelectRowCallback;
@property (nonatomic, copy) BIHandlerTableViewRowSelectionCallback didDeselectRowCallback;

@end
