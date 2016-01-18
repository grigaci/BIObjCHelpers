//
//  BITableAdditionalNoContentView.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 18/01/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import "BITableAdditionalNoContentView.h"

@interface BITableAdditionalNoContentView ()

@property (nonatomic, assign, readwrite) BITableAdditionalTypeView type;

@end

@implementation BITableAdditionalNoContentView

@synthesize type = _type;

#pragma mark - BITableAdditionalViewBase methods

- (void)commonSetup {
    [super commonSetup];
    self.type = BITableAdditionalTypeNoContentView;
}

@end
