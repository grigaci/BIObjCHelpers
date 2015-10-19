//
//  BIMockStarter.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/13/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIStarterProtocol.h"

typedef void(^BIMockStarterStartCallback)(void);

@interface BIMockStarter : NSObject<BIStarter>

@property (nonatomic, copy,  nullable) BIMockStarterStartCallback startCallback;
@property (nonatomic, strong, nonnull) NSDictionary *launchOptions;

@end
