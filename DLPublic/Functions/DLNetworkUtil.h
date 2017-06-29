//
//  MDNetworkUtil.h
//  CommonUnit
//
//  Created by GaoLun on 14-01-01.
//  Copyright (c) 2014年 HangZhou DeLan Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 网络操作相关的工具类
 */

@interface DLNetworkUtil : NSObject

/**
 获取IP地址
 
 @return ip地址
 */
+ (NSString *)getIPAddress;

/**
 获取wifi信息
 
 @return wifi信息的字典
 BSSID = "90:94:e4:3a:7d:f6";
 SSID = jykt;
 SSIDDATA = <6a796b74>;
 */
+ (NSDictionary *)getWifiInfo;

@end
