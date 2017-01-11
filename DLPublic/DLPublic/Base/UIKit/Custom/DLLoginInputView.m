//
//  DLLoginInputView.m
//  Chigo
//
//  Created by Jone on 29/11/2016.
//  Copyright © 2016 HangZhou DeLan Technology Co. All rights reserved.
//

#import "DLLoginInputView.h"
#import <DLPublic/UIView+Public.h>
#import "DLTextField.h"
#import "DLLoginViewConfig.h"
#import "DLLocalizableStandard.h"
#import "DLUILayout.h"
#import "DLTextFieldAttachment.h"
#import "DLBoxCheckButton.h"
#import <DLPublic/NSString+Public.h>

typedef NS_ENUM(NSUInteger, DLLoginTextFieldType) {
    DLLoginTextFieldTypeUsername,
    DLLoginTextFieldTypePassword,
};

@interface DLLoginInputView ()<UITextFieldDelegate>

@property (nonatomic, strong) DLTextFieldAttachment *usernameComponent;
@property (nonatomic, strong) DLTextFieldAttachment *passwordComponent;

@property (nonatomic, strong) DLBoxCheckButton *rememberPasswordButton;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *passwordSwitchButton;

@end

@implementation DLLoginInputView

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height) {
        frame.size = CGSizeMake(300, 280);
    }
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    [self setup];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;
    
    [self setup];
    
    return self;
}

- (void)setup {
    
    [self addSubview:self.usernameComponent];
    _usernameComponent.top = DLVerticalMargin;
    _usernameComponent.centerX = self.width / 2;
    
    [self addSubview:self.passwordComponent];
    _passwordComponent.top = _usernameComponent.bottom + DLVerticalMargin;
    _passwordComponent.centerX = _usernameComponent.centerX;
    
    [self addSubview:self.rememberPasswordButton];
    _rememberPasswordButton.centerY = _passwordComponent.bottom + 3 * DLVerticalMargin / 2;
    _rememberPasswordButton.left = _passwordComponent.left;
    
    [self addSubview:self.loginButton];
    self.loginButton.size = (CGSize){self.width, DLButtonHeight};
    self.loginButton.top = _passwordComponent.bottom + DLVerticalMargin * 3;
    self.loginButton.left = _passwordComponent.left;
}

#pragma mark - Action 

- (void)passwordSwitchButtonOnTouched:(UIButton *)passwordSwitchButton {
    passwordSwitchButton.selected = !passwordSwitchButton.selected;
}

- (void)rememberPasswordButtonOnTouched:(DLBoxCheckButton *)rememberPasswordButton {
    rememberPasswordButton.selected = !rememberPasswordButton.selected;
}

- (void)loginButtonOnTouched:(UIButton *)loginButton {
   
    NSString *username = _usernameComponent.textField.text;
    NSString *password = _passwordComponent.textField.text;
    
    NSString *errorMessage = nil;
    if (![username isNotEmpty]) {
        errorMessage = DLLocalizedString(@"input_username_empty");
    } else if (![password isNotEmpty]) {
        errorMessage = DLLocalizedString(@"input_password_empty");
    }
    
    [self endEditing:YES]; // Resign Keyboard
    NSDictionary *data = @{@"username" : username, @"password" : password};
    if ([_delegate respondsToSelector:@selector(loginInputView:userInfo:error:)]) {
        [_delegate loginInputView:self userInfo:data error:errorMessage];
    }
}

#pragma mark - Lazy Initialization

- (DLTextFieldAttachment *)usernameComponent {
    if (!_usernameComponent) {
        CGRect frame = {0, 0, self.width, DLTextFieldHeight};
        _usernameComponent = [[DLTextFieldAttachment alloc] initWithFrame:frame];
        _usernameComponent.imageView.image = [DLLoginViewConfig usernameIcon];
        _usernameComponent.textField.delegate = self;
        _usernameComponent.textField.textColor = [DLLoginViewConfig textColor];
        _usernameComponent.textField.placeholder = DLLocalizedString(@"username");
        _usernameComponent.textField.returnKeyType = UIReturnKeyNext;
        _usernameComponent.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _usernameComponent.textField.keyboardType = UIKeyboardTypeEmailAddress;
        _usernameComponent.textField.spellCheckingType = UITextSpellCheckingTypeNo;
        _usernameComponent.textField.autocorrectionType = UITextAutocorrectionTypeNo;
        _usernameComponent.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _usernameComponent.backgroudImageView.image = [DLLoginViewConfig textFieldBackgroundImage];
    }
    return _usernameComponent;
}

- (DLTextFieldAttachment *)passwordComponent {
    if (!_passwordComponent) {
        CGRect frame = {0, 0, self.width, DLTextFieldHeight};
        _passwordComponent = [[DLTextFieldAttachment alloc] initWithFrame:frame];
        _passwordComponent.imageView.image = [DLLoginViewConfig passwordIcon];
        UIImage *hiddenImage = [DLLoginViewConfig hiddenIcon];
        UIImage *dispalyedImage = [DLLoginViewConfig dispalyedIcon];
        [_passwordComponent setTextSecurityWithHidden:hiddenImage dispalyed:dispalyedImage];
        _passwordComponent.textField.delegate = self;
        _passwordComponent.textField.textColor = [DLLoginViewConfig textColor];
        _passwordComponent.textField.placeholder = DLLocalizedString(@"password");
        _passwordComponent.textField.returnKeyType = UIReturnKeyGo;
        _passwordComponent.textField.keyboardType = UIKeyboardTypeASCIICapable;
        _passwordComponent.textField.spellCheckingType = UITextSpellCheckingTypeNo;
        _passwordComponent.textField.autocorrectionType = UITextAutocorrectionTypeNo;
        _passwordComponent.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _passwordComponent.backgroudImageView.image = [DLLoginViewConfig textFieldBackgroundImage];
    }
    return _passwordComponent;
}

- (DLBoxCheckButton *)rememberPasswordButton {
    if (!_rememberPasswordButton) {
        _rememberPasswordButton = [[DLBoxCheckButton alloc] initWithFrame:(CGRect){0,0, self.width - 2 * DLHorizontalMargin, 30}];
        _rememberPasswordButton.textLabel.text = DLLocalizedString(@"remember_password");
        _rememberPasswordButton.textLabel.font = [UIFont systemFontOfSize:14.0];
        _rememberPasswordButton.textLabel.textColor = [DLLoginViewConfig rememberPasswordTextColor];
        _rememberPasswordButton.checkedImage = [DLLoginViewConfig boxCheckedIcon];
        _rememberPasswordButton.uncheckedImage = [DLLoginViewConfig boxUncheckedIcon];
        [_rememberPasswordButton addTarget:self action:@selector(rememberPasswordButtonOnTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rememberPasswordButton;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = [DLLoginViewConfig buttonBackgroundColor];
        [_loginButton setTitleColor:[DLLoginViewConfig buttonTextLabelColor] forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        UIImage *backgroundImage = [DLLoginViewConfig buttonBackgroundImage];
        if (backgroundImage) [_loginButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        [_loginButton setTitle:DLLocalizedString(@"login") forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginButtonOnTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (_usernameComponent.textField == textField) {
        [_passwordComponent.textField becomeFirstResponder];
    } else {
        [self loginButtonOnTouched:nil];
    }
    return YES;
}

@end
