//
//  MockUITableView.h
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 6/16/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MockUITableView : UITableView

- (nonnull instancetype)init;

@property (nonatomic, copy, nullable) void(^registerNibForCellReuseIdentifierCallback)(UINib *__nonnull nib, NSString *__nonnull identifier);
@property (nonatomic, copy, nullable) void(^registerClassForCellReuseIdentifierCallback)(Class __nonnull cellClass, NSString *__nonnull identifier);
@property (nonatomic, copy, nullable) void(^deleteRowsAtIndexPathsWithRowAnimationCallback)(NSArray * __nonnull indexPaths, UITableViewRowAnimation animation);
@property (nonatomic, copy, nullable) void(^insertRowsAtIndexPathsWithRowAnimationCallback)(NSArray * __nonnull indexPaths, UITableViewRowAnimation animation);
@property (nonatomic, copy, nullable) void(^deleteSectionsWithRowAnimationCallback)(NSIndexSet * __nonnull sections, UITableViewRowAnimation animation);
@property (nonatomic, copy, nullable) void(^insertSectionsWithRowAnimationCallback)(NSIndexSet * __nonnull sections, UITableViewRowAnimation animation);

@end
