//
//  UIApplication+Public.h
//  DLPublicDemo
//
//  Created by DeLan on 16/7/13.
//  Copyright © 2016年 DeLan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (Public)

/// Application's Documents path.
@property (nonatomic, readonly) NSString *documentsPath;

/// Application's Bundle Name.
@property (nonnull, nonatomic, readonly) NSString *appBundleName;

/// Application's Bundle ID. e.g. "com.idea-link.app.abc"
@property (nonnull, nonatomic, readonly) NSString *appBundleID;

/// Application's Version. e.g. "1.1.0"
@property (nonnull, nonatomic, readonly) NSString *appVersion;

/// Application's Bundle Version. e.g. "123"
@property (nonnull, nonatomic, readonly) NSString *appBuildVersion;

/**
 Increments the number of active network requests.
 If this number was zero before incrementing, this will start animating the
 status bar network activity indicator.
 
 This method is thread safe.
 
 This method has no effect in App Extension.
 */
- (void)incrementNetworkActivityCount;

/**
 Decrements the number of active network requests.
 If this number becomes zero after decrementing, this will stop animating the
 status bar network activity indicator.
 
 This method is thread safe.
 
 This method has no effect in App Extension.
 */
- (void)decrementNetworkActivityCount;


/// Returns YES in App Extension.
+ (BOOL)isAppExtension;

/// Same as sharedApplication, but returns nil in App Extension.
+ (nullable UIApplication *)sharedExtensionApplication;

@end

NS_ASSUME_NONNULL_END
