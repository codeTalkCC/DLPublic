//
//  DLLocalizableStandard.h
//  Chigo
//
//  Created by Jone on 29/11/2016.
//  Copyright © 2016 HangZhou DeLan Technology Co. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef DLLocalizedString
#define DLLocalizedString(key) [[DLLocalizableStandard sharedStandard] stringWithKey:key]
#endif

/**
 应用内部的国际化
 国际化文件的名称必须为：DLLocalizable.strings
 */
@interface DLLocalizableStandard : NSObject

/** */
+ (instancetype)sharedStandard;

/** zh-Hans: 简体中文 zh-Hant: 繁体中文 en: 英文  ko: 韩文 Fr: 法文 */
- (void)setUserlanguage:(NSString *)language;

/** 国际化资源文件包 */
- (NSBundle *)bundle;

/** 默认为系统语言 */
- (NSString *)currentLanguage;

- (NSString *)stringWithKey:(NSString *)key;

@end
