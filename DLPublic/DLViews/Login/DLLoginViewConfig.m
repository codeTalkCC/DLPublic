//
//  DLLoginConfig.m
//  Chigo
//
//  Created by Jone on 29/11/2016.
//  Copyright © 2016 HangZhou DeLan Technology Co. All rights reserved.
//

#import "DLLoginViewConfig.h"

static UIColor *_textColor = nil;
static UIColor *_placehodlerTextColor = nil;
static UIColor *_rememberPasswordTextColor = nil;
static UIColor *_buttonTextLabelColor = nil;
static UIColor *_buttonBackgroundColor = nil;
//static UIColor *_borderColor = nil;

static UIImage *_logoIcon = nil;
static UIImage *_usernameIcon = nil;
static UIImage *_passwordIcon = nil;
static UIImage *_boxCheckedIcon = nil;
static UIImage *_boxUncheckedIcon = nil;
static UIImage *_dispalyedIcon = nil;
static UIImage *_hiddenIcon = nil;
static UIImage *_textFieldBackgroundImage = nil;
static UIImage *_buttonBackgroundImage = nil;

@implementation DLLoginViewConfig

+ (UIColor *)textColor {
    return _textColor;
}

+ (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
}

+ (UIColor *)placeholderTextColor {
    return _placehodlerTextColor;
}

+ (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor {
    _placehodlerTextColor = placeholderTextColor;
}

+ (UIColor *)buttonTextLabelColor {
    return _buttonTextLabelColor;
}

+ (void)setButtonTextLabelColor:(UIColor *)buttonTextLabelColor {
    _buttonTextLabelColor = buttonTextLabelColor;
}

+ (UIColor *)buttonBackgroundColor {
    return _buttonBackgroundColor;
}

+ (void)setButtonBackgroundColor:(UIColor *)buttonBackgroundColor {
    _buttonBackgroundColor = buttonBackgroundColor;
}

+ (UIColor *)rememberPasswordTextColor {
    return _rememberPasswordTextColor;
}

+ (void)setRememberPasswordTextColor:(UIColor *)rememberPasswordTextColor {
    _rememberPasswordTextColor = rememberPasswordTextColor;
}

+ (UIImage *)logoIcon {
    return _logoIcon;
}

+ (void)setLogoIcon:(UIImage *)logoIcon {
    _logoIcon = logoIcon;
}

+ (UIImage *)usernameIcon {
    return _usernameIcon;
}

+ (void)setUsernameIcon:(UIImage *)usernameIcon {
    _usernameIcon = usernameIcon;
}

+ (UIImage *)boxCheckedIcon {
    return _boxCheckedIcon;
}

+ (void)setBoxCheckedIcon:(UIImage *)boxCheckedIcon {
    _boxCheckedIcon = boxCheckedIcon;
}

+ (UIImage *)boxUncheckedIcon {
    return _boxUncheckedIcon;
}

+ (void)setBoxUncheckedIcon:(UIImage *)boxUncheckedIcon {
    _boxUncheckedIcon = boxUncheckedIcon;
}

+ (UIImage *)passwordIcon {
    return _passwordIcon;
}

+ (void)setPasswordIcon:(UIImage *)passwordIcon {
    _passwordIcon = passwordIcon;
}

+ (UIImage *)dispalyedIcon {
    return _dispalyedIcon;
}

+ (void)setDispalyedIcon:(UIImage *)dispalyedIcon {
    _dispalyedIcon = dispalyedIcon;
}

+ (UIImage *)hiddenIcon {
    return _hiddenIcon;
}

+ (void)setHiddenIcon:(UIImage *)hiddenIcon {
    _hiddenIcon = hiddenIcon;
}

+ (UIImage *)buttonBackgroundImage {
    return _buttonBackgroundImage;
}

+ (void)setButtonBackgroundImage:(UIImage *)buttonBackgroundImage {
    _buttonBackgroundImage = buttonBackgroundImage;
}

+ (UIImage *)textFieldBackgroundImage {
    return _textFieldBackgroundImage;
}

+ (void)setTextFieldBackgroundImage:(UIImage *)textFieldBackgroundImage {
    _textFieldBackgroundImage = textFieldBackgroundImage;
}

@end
