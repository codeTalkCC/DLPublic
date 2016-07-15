//
//  DLLocationManager.h
//  Pods
//
//  Created by DeLan on 16/7/15.
//  Copyright © 2016年 HangZhou DeLan Technology Co. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DLLocation;
@interface DLLocationManager : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

/**
 Gets default manager.
 */
+ (instancetype)defaultManager;

/**
 Start updating location.
 
 This should configure with Info.plist after iOS8:
 
 NSLocationAlwaysUsageDescription = @"__YOUR_DESCRIPTION__";
 NSLocationWhenInUseUsageDescription = @"__YOUR_DESCRIPTION__";
 
 @param locationInfo A block execution when location success or failure.
 */
- (void)startUpdatingLocation:(void (^)(DLLocation *location, NSError *error))locationInfo;

@end

NS_ASSUME_NONNULL_END