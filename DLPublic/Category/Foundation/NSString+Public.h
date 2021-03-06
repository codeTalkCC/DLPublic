//
//  NSString+Public.h
//  DLPublicDemo
//
//  Created by DeLan on 16/7/14.
//  Copyright © 2016年 HangZhou DeLan Technology Co. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Public)

#pragma mark - Authenticate


/**
 语言国际化

 @return 本地化的语言
 */
- (NSString *)localString;

///=============================================================================
/// @name Authenticate For Login or Registration
///=============================================================================

/**
 Whether Login or Registration user name length between \e 4 and \e 64.
 
 @return If valid will Returns YES; otherwise Returns NO.
 If NO, prompt '请输入4～64位的用户名'.
 */
- (BOOL)stringIsUsername;

/**
 Whether string is phone number.
 
 if NO, prompt '请输入正确的手机号码'.
 手机号格式变换太快，判断手机号建议使用11长度，这个判断不标准
 */
- (BOOL)stringIsPhoneNumber;

/**
 Whether Login or Registration password length between \e 6 and \e 16.
 
 @return If valid will Returns YES; otherwise Returns NO.
 If NO, prompt '请输入6～16位的密码'.
 */
- (BOOL)stringIsPassword;

/**
 设备名称是否符合要求
 否：提示“请输入1～64位的设备名称”
 */
- (BOOL)isLegalDevName;


/**
 nil, @"", @"  ", @"\n" will Returns NO; otherwise Returns YES.
 
 @discussion 可用于判断用户名或者密码是否为空
 */
- (BOOL)isNotEmpty;


/**
 Whether string is cantain special character.
 
 @return Only contain number or character return NO, otherwise return YES.
 */
- (BOOL)containsSpecialCharacter;


/**
 Whether string is email.
 */
- (BOOL)stringIsEmail;

/**
 Whether string is URL.
 */
- (BOOL)stringIsURL;


#pragma mark - Utilities
///=============================================================================
/// @name Utilities
///=============================================================================

/**
 Trim blank characters (space and newline) in head and tail.
 @return the trimmed string.
 */
- (NSString *)stringByTrim;

/**
 Returns YES if the target string is contained within the receiver.
 @param string A string to test the the receiver.
 
 @discussion Apple has implemented this method in iOS8.
 */
- (BOOL)containsString:(NSString *)string;

/**
 Try to parse this string and returns an `NSNumber`.
 @return Returns an `NSNumber` if parse succeed, or nil if an error occurs.
 */
- (nullable NSNumber *)numberValue;

/**
 Caculates characters length, Chinese may occupy two.
 @return length of characters
 */
- (NSUInteger)charactersLength;

#pragma mark - Encode and decode
///=============================================================================
/// @name Encode and decode
///=============================================================================

/**
 URL encode a string in utf-8.
 @return the encoded string.
 */
- (NSString *)stringByURLEncode;

/**
 URL decode a string in utf-8.
 @return the decoded string.
 */
- (NSString *)stringByURLDecode;

/**
 Escape common HTML to Entity.
 Example: "a<b" will be escape to "a&lt;b".
 */
- (NSString *)stringByEscapingHTML;

#pragma mark - Hash

/**
 Returns a lowercase NSString for md5 hash.
 */
- (nullable NSString *)md5String;

@end

NS_ASSUME_NONNULL_END
