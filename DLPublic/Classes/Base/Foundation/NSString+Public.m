//
//  NSString+Public.m
//  DLPublicDemo
//
//  Created by Jone on 16/7/14.
//  Copyright © 2016年 DeLan. All rights reserved.
//

#import "NSString+Public.h"

@implementation NSString (Public)
- (NSString *)dl_stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}
@end
