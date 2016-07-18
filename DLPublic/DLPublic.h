//
//  DLPublic.h
//  Pods
//
//  Created by Jone on 16/7/15.
//  Copyright © 2016年 HangZhou DeLan Technology Co. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<DLPublic/Public.h>)

#import <DLPublic/DLPublicMacro.h>

#import <DLPublic/NSData+Public.h>
#import <DLPublic/NSDate+Public.h>
#import <DLPublic/NSNumber+Public.h>
#import <DLPublic/NSString+Public.h>
#import <DLPublic/NSDictionary+Public.h>

#import <DLPublic/UIView+Public.h>
#import <DLPublic/UIImage+Public.h>
#import <DLPublic/UIColor+Public.h>
#import <DLPublic/UIDevice+Public.h>
#import <DLPublic/UIControl+Public.h>
#import <DLPublic/UIResponder+Public.h>
#import <DLPublic/UIApplication+Public.h>
#import <DLPublic/UINavigationController+Public.h>

#import <DLPublic/DLSingleton.h>
#import <DLPublic/DLErrorParser.h>
#import <DLPublic/DLKeyboardManager.h>
#import <DLPublic/DLLocationManager.h>

#else

#import "DLPublicMacro.h"

#import "NSData+Public.h"
#import "NSNumber+Public.h"
#import "NSString+Public.h"
#import "NSDictionary+Public.h"

#import "UIView+Public.h"
#import "UIImage+Public.h"
#import "UIColor+Public.h"
#import "UIDevice+Public.h"
#import "UIControl+Public.h"
#import "UIResponder+Public.h"
#import "UIApplication+Public.h"
#import "UINavigationController+Public.h"

#import "DLSingleton.h"
#import "DLErrorParser.h"
#import "DLKeyboardManager.h"
#import "DLLocationManager.h"

#endif