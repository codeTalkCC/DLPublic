//
//  DLLoginConfig.h
//  Chigo
//
//  Created by Jone on 29/11/2016.
//  Copyright © 2016 HangZhou DeLan Technology Co. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 登录界面配置类
 */
@interface DLLoginViewConfig : NSObject

#if UIKIT_DEFINE_AS_PROPERTIES

/** 输入字体颜色 */
@property (class, nonatomic, nullable) UIColor *textColor;

/** Placehodler 字体颜色*/
@property (class, nonatomic, nullable) UIColor *placeholderTextColor;

/** 记住密码字体颜色 */
@property (class, nonatomic, nullable) UIColor *rememberPasswordTextColor;

/** 登录按钮字体颜色 */
@property (class, nonatomic, nullable) UIColor *buttonTextLabelColor;

/** 登录按钮背景颜色 */
@property (class, nonatomic, nullable) UIColor *buttonBackgroundColor;

/** 用户名图标 */
@property (class, nonatomic, nullable) UIImage *usernameIcon;

/** Logo 图标 */
@property (class, nonatomic, nullable) UIImage *logoIcon;

/** 密码图标 */
@property (class, nonatomic, nullable) UIImage *passwordIcon;

/** 记住密码未选中图标 */
@property (class, nonatomic, nullable) UIImage *boxUncheckedIcon;

/** 记住密码选中图标 */
@property (class, nonatomic, nullable) UIImage *boxCheckedIcon;

/** 密码显示图标 */
@property (class, nonatomic, nullable) UIImage *dispalyedIcon;

/** 密码隐藏图标 */
@property (class, nonatomic, nullable) UIImage *hiddenIcon;

/** 文本框背景图 */
@property (class, nonatomic, nullable) UIImage *textFieldBackgroundImage;

/** 按钮背景图片 */
@property (class, nonatomic, nullable) UIImage *buttonBackgroundImage;
#endif

@end

NS_ASSUME_NONNULL_END
