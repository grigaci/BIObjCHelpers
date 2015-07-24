//
//  BITableViewCell.m
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 7/17/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BITableViewCell.h"

@implementation BITableViewCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self configureSeparatorView];
}

- (void)configureSeparatorView {
    self.separatorView = [[UIView alloc] initWithFrame:(CGRect){.0f, CGRectGetMaxY(self.bounds) - 1, CGRectGetWidth(self.bounds), 1}];
    self.separatorView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.separatorView];
}

@end
