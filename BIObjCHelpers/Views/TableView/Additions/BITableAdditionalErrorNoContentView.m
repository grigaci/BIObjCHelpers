//
//  BITableAdditionalErrorNoContentView.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 18/01/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import "BITableAdditionalErrorNoContentView.h"

@interface BITableAdditionalErrorNoContentView ()

@property (nonatomic, assign, readwrite) BITableAdditionalTypeView type;

@end


@implementation BITableAdditionalErrorNoContentView

@synthesize type = _type;

#pragma mark - BITableAdditionalViewBase methods

- (void)commonSetup {
    [super commonSetup];
    self.type = BITableAdditionalTypeErrorNoContentView;
}

@end
