//
//  BIExampleCollectionViewCell.m
//  BIObjCHelpersExample
//
//  Created by Mihai Chifor on 9/1/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIExampleCollectionViewCell.h"

@interface BIExampleCollectionViewCell ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation BIExampleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    self.titleLabel.frame = CGRectMake(CGRectGetWidth(self.bounds) / 2.f - 10.f, CGRectGetHeight(self.bounds) / 2.f - 10.f, 20.f, 20.f);
//    [self.titleLabel sizeToFit];
}
#pragma mark - Properties Methods

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _titleLabel;
}

- (void)setImage:(UIImage *)image {
    if ([_image isEqual:image]) {
        return;
    }
    _image = image;
    self.imageView.image = _image;
}

- (void)setTitle:(NSString *)title {
    if ([_title isEqualToString:title]) {
        return;
    }
    _title = title;
    self.titleLabel.text = _title;
}

@end
