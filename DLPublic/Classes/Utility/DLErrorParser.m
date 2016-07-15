//
//  DLErrorParser.m
//  DLPublicDemo
//
//  Created by DeLan on 16/7/14.
//  Copyright © 2016年 DeLan. All rights reserved.
//

#import "DLErrorParser.h"
//#import "DLXMLParser.h"
#import "NSDictionary+Public.h"

@implementation DLErrorParser

+ (nullable NSString *)parseErrorCode:(NSInteger)errCode {
    BOOL chinese = [self currentSystemLanguageIsChinese];
    NSString *fileName = chinese ? @"errorCode_cn" : @"errorCode_en";
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
    NSData *xmlData = [NSData dataWithContentsOfFile:path];
    NSDictionary *resultDic = [NSDictionary dl_dictionaryWithXML:xmlData];
    NSArray *errDictArray = resultDic[@"error"];
    for (NSDictionary *itemDict in errDictArray) {
        NSString *code = itemDict[@"code"];
        if (code.integerValue == errCode) {
            return [NSString stringWithFormat:@"%@[%ld]", itemDict[@"text"], errCode];
        }
    }
    NSString *unknow = chinese ? @"未知错误" : @"Unknow Error";
    return [NSString stringWithFormat:@"%@[%ld]", unknow, errCode];
}

/**
 iOS 7
 zh-Hans: 简体
 zh-Hant: 繁体
 
 iOS8
 zh-Hans: 简体
 zh-Hant: 繁体
 zh-HK: 香港繁体(Add)
 
 iOS9
 zh-Hans-CN: 简体
 zh-Hant-CN: 繁体
 zh-TW:      台湾繁体（Add）
 en-CN
 zh-Hans-US
 en-US
 */
+ (BOOL)currentSystemLanguageIsChinese {
    static BOOL isChinese;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSArray *languages = [userDefaults objectForKey:@"AppleLanguages"];
        NSString *preferredLang = [languages objectAtIndex:0];
        if ([preferredLang isEqualToString:@"zh-Hans"]
            || [preferredLang isEqualToString:@"zh-Hans-CN"]) {
            isChinese = YES;
        } else {
            isChinese = NO;
        }
    });
    return isChinese;
}
@end
