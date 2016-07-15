//
//  NSDictionary+Public.h
//  DLPublicDemo
//
//  Created by Jone on 16/7/14.
//  Copyright © 2016年 DeLan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Public)

/**
 Try to parse an XML and wrap it into a dictionary.
 If you just want to get some value from a small xml, try this.
 
 @param xmlDataOrString XML in NSData or NSString format.
 @return Return a new dictionary, or nil if an error occurs.
 */
+ (nullable NSDictionary *)dl_dictionaryWithXML:(id)xmlDataOrString;

@end

NS_ASSUME_NONNULL_END