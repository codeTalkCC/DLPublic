//
//  UIAlertController+Public.m
//  Chigo
//
//  Created by Jone on 05/12/2016.
//  Copyright © 2016 HangZhou DeLan Technology Co. All rights reserved.
//

#import "UIAlertController+Public.h"

@implementation UIAlertController (Public)

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
               buttonTitle:(NSString *)buttonTitle
            fromController:(UIViewController *)controller {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:action];
    [controller presentViewController:alertController animated:YES completion:nil];
}

@end
