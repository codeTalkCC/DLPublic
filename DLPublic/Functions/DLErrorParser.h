//
//  DLErrorParser.h
//  DLPublicDemo
//
//  Created by DeLan on 16/7/14.
//  Copyright © 2016年 DeLan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLErrorParser : NSObject

/**
 Parses error message by error code.
 
 @param errCode A code gets from SDK error block
 */
+ (nullable NSString *)parseErrorCode:(NSInteger)errCode;

@end

NS_ASSUME_NONNULL_END