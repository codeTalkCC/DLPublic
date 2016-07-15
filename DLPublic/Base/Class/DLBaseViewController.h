//
//  DLBaseViewController.h
//  DLPublicDemo
//
//  Created by DeLan on 16/7/12.
//  Copyright © 2016年 HangZhou DeLan Technology Co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLPublicMacro.h"


@interface DLBaseViewController : UIViewController

/**
 Sets backgroud image above controller's view.
 */
- (void)setBackgroundImage:(UIImage *)backgroundImage;

/**
 Shows activity indicator view for loading.
 
 This method must be invoke on main thread.
 
 @param enable If `NO` don't allow user interaction.
 */
- (void)showHUDInteractionEable:(BOOL)enable;

/**
 Hides activity inidicator view, corresponds to use with `showHUDInteractionEable:`.
 
 This method must be invoke on main thread.
 */
- (void)hideHUD;

/**
 Shows alert view with messge.
 
 This method must be invoke on main thread.
 
 @param message A string message to show by alert view
 */
- (void)showAlertViewWithMessage:(NSString *)message;

/**
 Shows error message with error code by alert view.
 
 This method must be invoke on main thread.
 
 @param errCode A code gets from SDK error block
 */
- (void)showErrorMessageWithCode:(NSInteger)errCode;

@end
