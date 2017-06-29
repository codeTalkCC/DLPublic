//
//  DLPublic.h
//  Pods
//
//  Created by DeLan on 16/7/15.
//  Copyright © 2016年 HangZhou DeLan Technology Co. All rights reserved.
//


#ifdef __OBJC__

#import <Foundation/Foundation.h>

#if __has_include(<DLPublic/Public.h>)

//Foundation
#import <DLPublic/NSData+Public.h>
#import <DLPublic/NSDate+Public.h>
#import <DLPublic/NSNumber+Public.h>
#import <DLPublic/NSString+Public.h>
#import <DLPublic/NSDictionary+Public.h>

//UIKit
#import <DLPublic/UIAlertController+Public.h>
#import <DLPublic/UIApplication+Public.h>
#import <DLPublic/UIColor+Public.h>
#import <DLPublic/UIControl+Public.h>
#import <DLPublic/UIDevice+Public.h>
#import <DLPublic/UIImage+Public.h>
#import <DLPublic/UINavigationController+Public.h>
#import <DLPublic/UIResponder+Public.h>
#import <DLPublic/UIView+Public.h>

//Functions
#import <DLPublic/DLAdressPickerView.h>
#import <DLPublic/DLBaseViewController.h>
#import <DLPublic/DLDatePickerView.h>
#import <DLPublic/DLErrorParser.h>
#import <DLPublic/DLKeyboardManager.h>
#import <DLPublic/DLLocalizableStandard.h>
#import <DLPublic/DLLocationManager.h>
#import <DLPublic/DLPublicMacro.h>
#import <DLPublic/DLSingleton.h>
#import <DLPublic/DLTimer.h>
#import <DLPublic/DLScanViewController.h>
#import <DLPublic/DLNetworkUtil.h>
#else

//Foundation
#import "NSData+Public.h"
#import "NSDate+Public.h"
#import "NSNumber+Public.h"
#import "NSString+Public.h"
#import "NSDictionary+Public.h"

//UIKit
#import "UIAlertController+Public.h"
#import "UIApplication+Public.h"
#import "UIColor+Public.h"
#import "UIControl+Public.h"
#import "UIDevice+Public.h"
#import "UIImage+Public.h"
#import "UINavigationController+Public.h"
#import "UIResponder+Public.h"
#import "UIView+Public.h"

//Functions
#import "DLAdressPickerView.h"
#import "DLBaseViewController.h"
#import "DLDatePickerView.h"
#import "DLErrorParser.h"
#import "DLKeyboardManager.h"
#import "DLLocalizableStandard.h"
#import "DLLocationManager.h"
#import "DLPublicMacro.h"
#import "DLSingleton.h"
#import "DLTimer.h"
#import "DLScanViewController.h"
#import "DLNetworkUtil.h"

#endif
#endif
