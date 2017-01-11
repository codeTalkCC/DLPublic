//
//  DLLoginView.m
//  Chigo
//
//  Created by Jone on 02/12/2016.
//  Copyright © 2016 HangZhou DeLan Technology Co. All rights reserved.
//

#import "DLLoginView.h"
#import "DLLoginInputView.h"
#import <DLPublic/UIView+Public.h>
#import "DLLocalizableStandard.h"
#import "DLLoginViewConfig.h"
#import "DLUILayout.h"
#import <DLPublic/DLPublic.h>
#import "DLBoxCheckButton.h"
#import "DLTextFieldAttachment.h"
#import "DLTextField.h"

@interface DLLoginView()<DLLoginInputViewDelegate>

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) DLLoginInputView *inputView;
@property (nonatomic, strong) UIButton *forgetPasswordButton;
@property (nonatomic, strong) UIButton *registerButton;

@end

@implementation DLLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.height == 0 && frame.size.width == 0) {
        frame = [[UIScreen mainScreen] bounds];
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

#pragma mark -

- (BOOL)rememberPasword {
    return _inputView.rememberPasswordButton.selected;
}

- (void)displayCachedUsername:(NSString *)password {
    _inputView.usernameComponent.textField.text = password;
}

- (void)dispalyCachedPassword:(NSString *)username {
    _inputView.passwordComponent.textField.text = username;
    _inputView.rememberPasswordButton.selected = YES;
}

#pragma mark - Action

// Password forget
- (void)forgetPasswordButtonOnTouched:(id)sender {
    if ([_delegate respondsToSelector:@selector(triggeredForgetPasswordAction)]) {
        [_delegate triggeredForgetPasswordAction];
    }
}

// Register
- (void)registerButtonOnTouched:(id)sender {
    if ([_delegate respondsToSelector:@selector(triggeredRegisterAction)]) {
        [_delegate triggeredRegisterAction];
    }
}

#pragma mark - DLLoginInputViewDelegate

- (void)loginInputView:(DLLoginInputView *)loginInputView userInfo:(NSDictionary *)userInfo error:(NSString *)errorMessage {
    if ([_delegate respondsToSelector:@selector(triggeredLoginActionWithUserInfo:error:)]) {
        [_delegate triggeredLoginActionWithUserInfo:userInfo error:errorMessage];
    }
}

#pragma mark - Public
#pragma mark -

- (void)setup {

    _inputView = [[DLLoginInputView alloc] initWithFrame:(CGRect){0,0, 300, 280}];
    _inputView.delegate = self;
    [self addSubview:_inputView];
    _inputView.center = self.center;

    _logoImageView = [[UIImageView alloc] initWithImage:[DLLoginViewConfig logoIcon]];
    _logoImageView.size = (CGSize){178, 80};
    _logoImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:_logoImageView];
    _logoImageView.bottom = _inputView.top - DLVerticalMargin;
    _logoImageView.centerX = self.width / 2;
    
    _forgetPasswordButton = [self customButton];
    [_forgetPasswordButton setTitle:DLLocalizedString(@"forget_password") forState:UIControlStateNormal];
    [_forgetPasswordButton sizeToFit];
    _forgetPasswordButton.bottom = self.bottom - DLVerticalMargin;
    _forgetPasswordButton.left = DLHorizontalMargin;
    [self addSubview:_forgetPasswordButton];
    [_forgetPasswordButton addTarget:self action:@selector(forgetPasswordButtonOnTouched:)
                    forControlEvents:UIControlEventTouchUpInside];
    
    _registerButton = [self customButton];
    [_registerButton setTitle:DLLocalizedString(@"register") forState:UIControlStateNormal];
    [_registerButton sizeToFit];
    _registerButton.centerY = _forgetPasswordButton.centerY;
    _registerButton.right = self.right - DLHorizontalMargin;
    [self addSubview:_registerButton];
    [_registerButton addTarget:self action:@selector(registerButtonOnTouched:)
              forControlEvents:UIControlEventTouchUpInside];
}

- (UIButton *)customButton {
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    customButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [customButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    return customButton;
}

@end
