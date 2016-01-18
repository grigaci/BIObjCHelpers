//
//  BITableAdditionalViewBase.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 18/01/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import "BITableAdditionalViewBase.h"

@interface BITableAdditionalViewBase ()

@property (nonatomic, strong, nullable, readwrite) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong, nonnull, readwrite) NSHashTable<BITableAdditionalViewBaseListener> *contentViewListeners;
@property (nonatomic, assign, readwrite) BITableAdditionalTypeView type;

@end


@implementation BITableAdditionalViewBase

#pragma mark - Init methods

- (nonnull instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonSetup];
    }
    return self;
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonSetup];
    }
    return self;
}

#pragma mark - Public methods

- (void)commonSetup {
    [self addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)registerAdditionalViewListeners:(nonnull id<BITableAdditionalViewBaseListener>)listener {
    [self.contentViewListeners addObject:listener];
}

- (void)unregisterAdditionalViewListeners:(nonnull id<BITableAdditionalViewBaseListener>)listener {
    [self.contentViewListeners removeObject:listener];
}

- (void)notifyAdditionalViewListenersOnDidTapEvent {
    if (self.didTapContentViewCallback) {
        self.didTapContentViewCallback();
    }
    
    for (id<BITableAdditionalViewBaseListener> listener in [self.contentViewListeners copy]) {
        if ([listener respondsToSelector:@selector(didTapTableAdditionalView:)]) {
            [listener didTapTableAdditionalView:self];
        }
    }
}

- (void)handleAdditionalViewTapGesture:(nonnull UITapGestureRecognizer *)tapGesture {
    [self notifyAdditionalViewListenersOnDidTapEvent];
}

#pragma mark - Property methods

- (UITapGestureRecognizer *)tapGestureRecognizer {
    if (!_tapGestureRecognizer) {
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleAdditionalViewTapGesture:)];
    }
    return _tapGestureRecognizer;
}

- (NSHashTable<BITableAdditionalViewBaseListener> *)contentViewListeners {
    if (!_contentViewListeners) {
        _contentViewListeners = (NSHashTable<BITableAdditionalViewBaseListener> *)[NSHashTable weakObjectsHashTable];
    }
    return _contentViewListeners;
}

@end
