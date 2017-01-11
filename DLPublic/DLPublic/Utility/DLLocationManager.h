//
//  DLLocationManager.h
//  Pods
//
//  Created by DeLan on 16/7/15.
//  Copyright © 2016年 HangZhou DeLan Technology Co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Locaion Infomation.
 */
@interface DLLocation : NSObject

@property (nonnull, nonatomic, readonly) NSString *province;
@property (nonnull, nonatomic, readonly) NSString *city;
@property (nonnull, nonatomic, readonly) NSString *district;

@end

@interface DLLocationManager : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

/**
 Gets default manager.
 */
+ (instancetype)defaultManager;

/**
 Starts updating location, used for get weather state.
 The location will be auto stop after block executed.
 
 @discuss:
 This should configure with Info.plist after iOS8:
 NSLocationAlwaysUsageDescription = @"__YOUR_DESCRIPTION__";
 NSLocationWhenInUseUsageDescription = @"__YOUR_DESCRIPTION__";
 
 @param locationInfo A block to be executed when location success or failure.
 */
- (void)startUpdatingLocation:(void (^)(DLLocation *location, NSError *error))locationInfo;

/**
 Starts updating location, use 'stopUpdateLocation' to stop.
 
 @param desiredAccuracy The desired location accuracy.
 @param didUpdateBlock  A block to be executed when location updated.
 */
- (void)startUpdationLoactionAccuracy:(CLLocationAccuracy)desiredAccuracy
                   didUpdateLocations:(void(^)(NSArray<CLLocation *> *locations))didUpdateBlock;

/**
 Stops updating locations.
 */
- (void)stopUpdateLocation;

@end

NS_ASSUME_NONNULL_END
