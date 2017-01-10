//
//  DLLoginInputView.h
//  Chigo
//
//  Created by Jone on 29/11/2016.
//  Copyright © 2016 HangZhou DeLan Technology Co. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DLTextFieldAttachment;
@class DLBoxCheckButton;

@class DLLoginInputView;
@protocol DLLoginInputViewDelegate <NSObject>

/**
 登录按钮回调

 @param loginInputView 登录视图
 @param userInfo {@"username": 用户名, @"password" : 密码}.
 @param errorMessage 输入格式错误信息
 */
- (void)loginInputView:(DLLoginInputView *)loginInputView userInfo:(nonnull NSDictionary *)userInfo error:(NSString *)errorMessage;

@end

/**
 登录界面组件
 
 包含用户名输入框、密码输入框、登录按钮等。
 */
@interface DLLoginInputView : UIView

@property (nonatomic, readonly) DLTextFieldAttachment *usernameComponent;
@property (nonatomic, readonly) DLTextFieldAttachment *passwordComponent;
@property (nonatomic, readonly) DLBoxCheckButton *rememberPasswordButton;

@property (nonatomic, weak) id<DLLoginInputViewDelegate> delegate;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@end

NS_ASSUME_NONNULL_END
