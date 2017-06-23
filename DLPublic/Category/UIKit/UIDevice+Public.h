//
//  UIDevice+Public.h
//  DLPublicDemo
//
//  Created by DeLan on 16/7/13.
//  Copyright © 2016年 DeLan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

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

#ifndef kDLiOS7Later
#define kDLiOS7Later (kSystemVersion >= 7)
#endif

#ifndef kDLiOS8Later
#define kDLiOS8Later (kSystemVersion >= 8)
#endif

#ifndef kDLiOS9Later
#define kDLiOS9Later (kSystemVersion >= 9)
#endif

#ifndef kDLiOS10Later
#define kDLiOS10Later (kSystemVersion >= 10)
#endif

// main screen's size (portrait)
#ifndef kDLScreenSize
#define kDLScreenSize YYScreenSize()
#endif

// main screen's width (portrait)
#ifndef kDLScreenWidth
#define kDLScreenWidth kDLScreenSize().width
#endif

// main screen's height (portrait)
#ifndef kDLScreenHeight
#define kDLScreenHeight kDLScreenSize().height
#endif


@end

NS_ASSUME_NONNULL_END
