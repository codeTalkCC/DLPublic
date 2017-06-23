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

@property (nonnull, nonatomic, readonly) NSString *province;    //省
@property (nonnull, nonatomic, readonly) NSString *city;        //市
@property (nonnull, nonatomic, readonly) NSString *district;    //区
@property (assign, nonatomic, readonly) CGFloat longitude;      //经度
@property (assign, nonatomic, readonly) CGFloat latitude;       //纬度
@property (assign, nonatomic, readonly) CGFloat altitude;       //高度
@property (strong, nonatomic, readonly) NSString *postalCode;   //邮政编码

@end

@interface DLLocationManager : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

/**
 Gets default manager.
 */
+ (instancetype)defaultManager;

@property (strong, nonatomic)DLLocation *currentLocation;

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
