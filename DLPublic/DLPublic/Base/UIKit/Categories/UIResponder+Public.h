//
//  UIResponder+Public.h
//  DLPublicDemo
//
//  Created by DeLan on 16/7/14.
//  Copyright © 2016年 DeLan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (Public)

/**
 Gets current first responder. e.g. UITextField
 */
- (id)currentFirstResponder;

@end

NS_ASSUME_NONNULL_END