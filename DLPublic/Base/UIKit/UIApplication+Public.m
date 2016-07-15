//
//  UIApplication+Public.m
//  DLPublicDemo
//
//  Created by DeLan on 16/7/13.
//  Copyright © 2016年 DeLan. All rights reserved.
//

#import "UIApplication+Public.h"
#import "DLPublicMacro.h"
#import <objc/runtime.h>

// Dummy class for category
@interface UIApplication_Public : NSObject @end
@implementation UIApplication_Public @end

/// A class for record network indicator info.
@interface _DLUIApplicationNetworkIndicatorInfo : NSObject
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation _DLUIApplicationNetworkIndicatorInfo
@end


@implementation UIApplication (Public)

- (NSString *)documentsPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

- (NSString *)appBundleName {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
}

- (NSString *)appBundleID {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}

- (NSString *)appVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

- (NSString *)appBuildVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}


- (_DLUIApplicationNetworkIndicatorInfo *)networkActivityInfo {
    return objc_getAssociatedObject(self, @selector(setNetworkActivityInfo:));
}

- (void)setNetworkActivityInfo:(_DLUIApplicationNetworkIndicatorInfo *)networkIndicator {
    [self willChangeValueForKey:@"networkActivityInfo"];
    objc_setAssociatedObject(self, _cmd, networkIndicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"networkActivityInfo"];
}

- (void)_delaySetActivity:(NSTimer *)timer {
    NSNumber *visible = timer.userInfo;
    if (self.networkActivityIndicatorVisible != visible.boolValue) {
        [self setNetworkActivityIndicatorVisible:visible.boolValue];
    }
    [timer invalidate];
}

- (void)_changeNetworkActivityCount:(NSInteger)delta {
    @synchronized(self){
        dispatch_async_on_main_queue(^{
            _DLUIApplicationNetworkIndicatorInfo *info = [self networkActivityInfo];
            if (!info) {
                info = [_DLUIApplicationNetworkIndicatorInfo new];
                [self setNetworkActivityInfo:info];
            }
            NSInteger count = info.count;
            count += delta;
            info.count = count;
            [info.timer invalidate];
            info.timer = [NSTimer timerWithTimeInterval:1/30.0 target:self selector:@selector(_delaySetActivity:) userInfo:@(info.count > 0) repeats:NO];
            [[NSRunLoop mainRunLoop] addTimer:info.timer forMode:NSRunLoopCommonModes];
        });
    }
}

- (void)incrementNetworkActivityCount {
    [self _changeNetworkActivityCount:1];
}

- (void)decrementNetworkActivityCount {
    [self _changeNetworkActivityCount:-1];
}

+ (BOOL)isAppExtension {
    static BOOL isAppExtension = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = NSClassFromString(@"UIApplication");
        if(!cls || ![cls respondsToSelector:@selector(sharedApplication)]) isAppExtension = YES;
        if ([[[NSBundle mainBundle] bundlePath] hasSuffix:@".appex"]) isAppExtension = YES;
    });
    return isAppExtension;
}

+ (nullable UIApplication *)sharedExtensionApplication {
#pragma clang diagnostic push
#pragma clang dianostic ignored "-Wundeclared-selector"
    return [self isAppExtension] ? nil : [UIApplication performSelector:@selector(sharedApplication)]; /*MetaClass instance*/
#pragma clang diagnostic pop
}
@end
