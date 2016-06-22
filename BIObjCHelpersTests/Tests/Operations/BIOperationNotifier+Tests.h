//
//  BIOperationNotifier+Tests.h
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 6/22/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import <BIObjCHelpers/BIObjCHelpers.h>

@interface BIOperationNotifier (Tests)

@property (nonatomic, strong, nullable, readwrite) NSHashTable <id<BIOperationNotifierListener>> *operationFinishedListeners;

@end
