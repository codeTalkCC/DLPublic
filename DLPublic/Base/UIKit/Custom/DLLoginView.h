//
//  DLLoginView.h
//  Chigo
//
//  Created by Jone on 02/12/2016.
//  Copyright © 2016 HangZhou DeLan Technology Co. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DLLoginView;
@protocol DLLoginViewDelegate <NSObject>

/** Login button on touched. */
- (void)triggeredLoginActionWithUserInfo:(nonnull NSDictionary *)dictionary error:(NSString *)errorMessage;

/** Register button on touched. */
- (void)triggeredRegisterAction;

/** Forget password on touched. */
- (void)triggeredForgetPasswordAction;

@end

@interface DLLoginView : UIView

@property (nonatomic, readonly) BOOL rememberPasword;
@property (nonatomic, weak) id<DLLoginViewDelegate> delegate;

- (void)displayCachedUsername:(NSString *)username;
- (void)dispalyCachedPassword:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
