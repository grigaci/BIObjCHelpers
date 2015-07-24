//
//  BIBaseDefines.h
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 7/16/15.
//  Copyright © 2015 iGama Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, BIScrollDirection) {
    BIScrollDirectionNone  = 0,
    BIScrollDirectionRight = 1 << 0,
    BIScrollDirectionLeft  = 1 << 1,
    BIScrollDirectionUp    = 1 << 2,
    BIScrollDirectionDown  = 1 << 3
};
