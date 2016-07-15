//
//  NSString+Public.h
//  DLPublicDemo
//
//  Created by Jone on 16/7/14.
//  Copyright © 2016年 DeLan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Public)

/**
 Trim blank characters (space and newline) in head and tail.
 @return the trimmed string.
 */
- (NSString *)dl_stringByTrim;

@end

NS_ASSUME_NONNULL_END