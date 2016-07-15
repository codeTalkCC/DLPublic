//
//  UIDevice+Public.h
//  DLPublicDemo
//
//  Created by DeLan on 16/7/13.
//  Copyright © 2016年 DeLan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Public)

#pragma mark - Device Information
///=============================================================================
/// @name Device Information
///=============================================================================

/// Device system version (e.g. 8.1)
+ (double)systemVersion;

/// Whether the device is iPad/iPad mini.
@property (nonatomic, readonly) BOOL isPad;

/// Whether the device is a simulator.
@property (nonatomic, readonly) BOOL isSimulator;

/// Wherher the device can make phone calls.
@property (nonatomic, readonly) BOOL canMakePhoneCalls NS_EXTENSION_UNAVAILABLE_IOS("");

#pragma mark - Network Information
///=============================================================================
/// @name Network Information
///=============================================================================

/// A string uniquely identify the device. e.g. "E621E1F8-C36C-495A-93FC-0C247A3E6E5F"
@property (nonnull ,nonatomic, readonly) NSString *UUID;

/// WIFI SSID of this device connected (can be nil). e.g. @"DeLan_Office"
@property (nullable, nonatomic, readonly) NSString *SSID;

/// The mac-address of the device connected router (can be nil).
@property (nullable, nonatomic, readonly) NSString *BSSID;

/// WIFI IP address of this device (can be nil). e.g. @"192.168.1.111"
@property (nullable, nonatomic, readonly) NSString *ipAddressWIFI;

/// Cell IP address of this device (can be nil). e.g. @"10.2.2.222"
@property (nullable, nonatomic, readonly) NSString *ipAddressCell;


/**
 Device System
 */
#ifndef kSystemVersion
#define kSystemVersion [UIDevice systemVersion]
#endif

#ifndef kiOS7Later
#define kiOS7Later (kSystemVersion >= 7)
#endif

#ifndef kiOS8Later
#define kiOS8Later (kSystemVersion >= 8)
#endif

#ifndef kiOS9Later
#define kiOS9Later (kSystemVersion >= 9)
#endif

@end
