//
//  UIView+LoadXib.m
//  Pods
//
//  Created by Mihai Chifor on 7/16/15.
//
//

#import "UIView+LoadXib.h"

@implementation UIView (LoadXib)

+ (instancetype)viewFromXib {
    NSString *className = NSStringFromClass(self);
    UIView *view = [[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil][0];
    
    NSAssert([view isKindOfClass:self], @"View class should match");
    
    return view;
}

@end
