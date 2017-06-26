//
//  NSData+Public.h
//  Pods
//
//  Created by DeLan on 16/7/15.
//  Copyright © 2016年 HangZhou DeLan Technology Co.. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (Public)

#pragma mark - JSON
- (NSDictionary *)jsonDic;

#pragma mark - Hash
///=============================================================================
/// @name Hash
///=============================================================================

/**
 Returns an NSData for md5 hash.
 */
- (NSData *)md5Data;

/**
 Returns a lowercase NSString for md5 hash.
 */
- (NSString *)md5String;


#pragma mark - Encrypt and Decrypt
///=============================================================================
/// @name Encrypt and Decrypt
///=============================================================================

/**
 Returns an encrypted NSData using AES.
 
 @param key   A key length of 16, 24 or 32 (128, 192 or 256bits).
 
 @param iv    An initialization vector length of 16(128bits).
 Pass nil when you don't want to use iv.
 
 @return      An NSData encrypted, or nil if an error occurs.
 */
- (nullable NSData *)aes256EncryptWithKey:(NSData *)key iv:(nullable NSData *)iv;

/**
 Returns an decrypted NSData using AES.
 
 @param key   A key length of 16, 24 or 32 (128, 192 or 256bits).
 
 @param iv    An initialization vector length of 16(128bits).
 Pass nil when you don't want to use iv.
 
 @return      An NSData decrypted, or nil if an error occurs.
 */
- (nullable NSData *)aes256DecryptWithkey:(NSData *)key iv:(nullable NSData *)iv;


#pragma mark - Encode and decode
///=============================================================================
/// @name Encode and decode
///=============================================================================

/**
Returns string decoded in UTF8.
*/
- (nullable NSString *)utf8String;

/**
Returns a uppercase NSString in HEX.
 */
- (nullable NSString *)hexString;

/**
 Returns an NSData from hex string.
 
 @param hexString   The hex string which is case insensitive.
 
 @return a new NSData, or nil if an error occurs.
 */
+ (nullable NSData *)dataWithHexString:(NSString *)hexString;

/**
 Returns an NSDictionary or NSArray for decoded self.
 Returns nil if an error occurs.
 */
- (nullable id)jsonValueDecoded;


@end

NS_ASSUME_NONNULL_END
