//
//  UIAlertController+Public.h
//  Chigo
//
//  Created by Jone on 05/12/2016.
//  Copyright © 2016 HangZhou DeLan Technology Co. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Public)

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
               buttonTitle:(NSString *)buttonTitle
            fromController:(UIViewController *)controller;

@end
