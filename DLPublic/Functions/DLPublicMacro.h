//
//  DLPublicMacro.h
//  DLPublicDemo
//
//  Created by DeLan on 16/7/12.
//  Copyright © 2016年 HangZhou DeLan Technology Co. All rights reserved.
//

#ifdef __OBJC__

#import <pthread.h>

#ifndef DLPublicMacro_h
#define DLPublicMacro_h

/**
 Debug Log
 */
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s[%d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif


/**
 UIKit
 */
#define DLApplication [UIApplication sharedApplication]
#define DLApplicationDelegate [[UIApplication sharedApplication] delegate]

#define DLMainScreen [UIScreen mainScreen]

#define DLNaviBar self.navigationController.navigationBar
#define DLTabBar  self.tabBarController.tabBar

/**
 Foundation
 */
#define DLNotificationCenter [NSNotificationCenter defaultCenter]
#define DLAddNotification(n, sel) [kNotificationCenter addObserver:self selector:@selector(sel) name:n object:nil]
#define DLRemoveNotification(n) [kNotificationCenter removeObserver:self name:n object:nil]
#define DLPostNotification(name) [kNotificationCenter postNotificationName:v object:nil userInfo:nil]


#define DLUserDefault [NSUserDefaults standardUserDefaults]
#define DLMainBundle  [NSBundle mainBundle]


/**
 Convert degrees to radians.
 */
static inline CGFloat DegreesToRadians(CGFloat degrees) {
    return degrees * M_PI / 180;
}

/**
 Convert radians to degrees.
 */
static inline CGFloat RadiansToDegrees(CGFloat radians) {
    return radians * 180 / M_PI;
}

/**
 Whether in main queue/thread.
 */
static inline bool dl_dispatch_is_main_queue() {
    return pthread_main_np() != 0;
}

/**
 Submits a block for asynchronous execution on a background queue and returns immediately.
 */
static inline void dl_dispatch_async_on_global_queue(void (^block)(void)) {
    if (pthread_main_np()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
    } else {
        block();
    }
}


/**
 Submits a block for asynchronous execution on a main queue and returns immediately.
 */
static inline void dl_dispatch_async_on_main_queue(void (^block)(void)) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

/**
 Submits a block for execution on a main queue and waits until the block completes.
 */
static inline void dl_dispatch_sync_on_main_queue(void (^block)(void)) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

#endif /* DLPublicMacro_h */

#endif
