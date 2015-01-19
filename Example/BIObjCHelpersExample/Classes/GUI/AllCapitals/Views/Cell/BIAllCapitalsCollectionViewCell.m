//
//  BIAllCapitalsCollectionViewCell.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/16/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIAllCapitalsCollectionViewCell.h"

@interface BIAllCapitalsCollectionViewCell ()

@property (nonatomic, readwrite, strong) UILabel *label;

@end

@implementation BIAllCapitalsCollectionViewCell

#pragma mark - Init methods

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.label];
        [self setupConstraints];
    }
    return self;
}

#pragma mark - Property methods

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _label;
}

#pragma mark - Autolayout methods

- (void)setupConstraints {
    id label = self.label;
    NSDictionary *views = NSDictionaryOfVariableBindings(label);
    NSArray *constraintsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label]|" options:0 metrics:nil views:views];
    NSArray *constraintsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label]|" options:0 metrics:nil views:views];
    [self addConstraints:constraintsH];
    [self addConstraints:constraintsV];
}

@end