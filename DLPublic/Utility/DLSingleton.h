//
//  ASingleton.h

//
//  Created by GaoLun on 15/5/5.
//  Copyright (c) 2015年 HangZhou DeLan Technology Co., Ltd. All rights reserved.
//

#ifndef SmartControl_ASingleton_h
#define SmartControl_ASingleton_h


// ## : 连接字符串和参数
#define SINGLETON_H(name) + (instancetype)shared##name;

#if __has_feature(objc_arc) // ARC

#define SINGLETON_M(name)                           \
static id _instance;                                \
+ (id)allocWithZone:(struct _NSZone *)zone          \
{                                                   \
    static dispatch_once_t onceToken;               \
    dispatch_once(&onceToken, ^{                    \
        _instance = [super allocWithZone:zone];     \
    });                                             \
    return _instance;                               \
}                                                   \
                                                    \
+ (instancetype)shared##name                        \
{                                                   \
    static dispatch_once_t onceToken;               \
    dispatch_once(&onceToken, ^{                    \
        _instance = [[self alloc] init];            \
    });                                             \
    return _instance;                               \
}                                                   \
+ (id)copyWithZone:(struct _NSZone *)zone           \
{                                                   \
    return _instance;                               \
}                                                   \

#else // 非ARC

#define SINGLETON_M(name)                           \
static id _instance;                                \
+ (id)allocWithZone:(struct _NSZone *)zone          \
{                                                   \
    static dispatch_once_t onceToken;               \
    dispatch_once(&onceToken, ^{                    \
        _instance = [super allocWithZone:zone];     \
    });                                             \
    return _instance;                               \
}                                                   \
                                                    \
+ (instancetype)shared##name                        \
{                                                   \
    static dispatch_once_t onceToken;               \
    dispatch_once(&onceToken, ^{                    \
        _instance = [[self alloc] init];            \
    });                                             \
    return _instance;                               \
}                                                   \
                                                    \
- (oneway void)release                              \
{                                                   \
                                                    \
}                                                   \
                                                    \
- (id)autorelease                                   \
{                                                   \
    return _instance;                               \
}                                                   \
                                                    \
- (id)retain                                        \
{                                                   \
    return _instance;                               \
}                                                   \
                                                    \
- (NSUInteger)retainCount                           \
{                                                   \
    return 1;                                       \
}                                                   \
                                                    \
+ (id)copyWithZone:(struct _NSZone *)zone           \
{                                                   \
    return _instance;                               \
}                                                   \

#endif



#endif