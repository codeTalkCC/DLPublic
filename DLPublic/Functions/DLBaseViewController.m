//
//  DLBaseViewController.m
//  DLPublicDemo
//
//  Created by DeLan on 16/7/12.
//  Copyright © 2016年 HangZhou DeLan Technology Co. All rights reserved.
//

#import "DLBaseViewController.h"
#import "DLErrorParser.h"
#import "UIResponder+Public.h"
#import "UIView+Public.h"
#import "UIDevice+Public.h"

#import "DLKeyboardManager.h"
#import "UIResponder+Public.h"

@interface DLBaseViewController ()<DLKeyboardObserver>


@end

@implementation DLBaseViewController {
    UIActivityIndicatorView *_indicator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加键盘的观察者
    [[DLKeyboardManager defaultManager]addObserver:self];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:backgroundImage];
    imageView.frame = self.view.bounds;
    [self.view insertSubview:imageView atIndex:0];
}

#pragma mark - HUD

- (void)showHUDInteractionEable:(BOOL)enable {
    self.navigationController.view.userInteractionEnabled = enable;
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _indicator.frame = CGRectMake(0, 0, 80, 80);
    _indicator.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    _indicator.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.8];
    _indicator.clipsToBounds = YES;
    _indicator.layer.cornerRadius = 6;
    [_indicator startAnimating];
    [self.view addSubview:_indicator];
}

- (void)hideHUD {
    [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _indicator.frame = CGRectZero;
        _indicator.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    } completion:^(BOOL finished) {
        [_indicator removeFromSuperview];
        self.navigationController.view.userInteractionEnabled = YES;
    }];
}

#pragma mark - Alert

- (void)showAlertViewWithMessage:(NSString *)message {
    if (kDLiOS8Later) {
        [self showAlterControllerWithMessage:message];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
#pragma clang diagnostic pop
    }
}

- (void)showAlterControllerWithMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showErrorMessageWithCode:(NSInteger)errCode {
    NSString *errMessage = [DLErrorParser parseErrorCode:errCode];
    [self showAlertViewWithMessage:errMessage];
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

#pragma mark @protocol DLKeyboardObserver

- (void)keyboardChangedWithTransition:(DLKeyboardTransition)transition {
    UIWindow *keyboardWindow = [[DLKeyboardManager defaultManager] keyboardWindow];
    CGRect toFrame = [[DLKeyboardManager defaultManager] convertRect:transition.toFrame toView:keyboardWindow];
//    CGRect fromFrame = [[DLKeyboardManager defaultManager] convertRect:transition.fromFrame toView:keyboardWindow];
    UIView *firstResponder = [self.view currentFirstResponder];
    if (firstResponder &&
        ([firstResponder isKindOfClass:[UITextField class]] ||
         [firstResponder isKindOfClass:[UITextView class]])) {
            BOOL willShow = [[DLKeyboardManager defaultManager] isKeyboardVisible];
            //firstResponder在整个view的位置
            CGFloat locationBYInView = firstResponder.height; //在整个view当中tf的底部距离顶端的距离
            UIView *resultView = firstResponder;
            do {
                locationBYInView += resultView.top;
                resultView = resultView.superview;
            } while (resultView != self.view && resultView != nil);
            
            if(willShow){
                if (locationBYInView > CGRectGetMinY(toFrame)) {
                    //使输入框不被遮挡
                    CGFloat device = locationBYInView - CGRectGetMinY(toFrame) + 8;
                    CGFloat buttomY = self.view.frame.size.height - device;
                    [self adjustFirstResponderWithBy:buttomY duration:transition.animationDuration];
                    
                    //使界面底部不被遮挡
//                    [self adjustFirstResponderWithFrame:toFrame duration:transition.animationDuration];
                    
                }
            }else{
                if (self.view.bottom < self.view.frame.size.height) {
                    [self adjustFirstResponderWithFrame:toFrame duration:transition.animationDuration];
                }
            }
    }
}

- (void)adjustFirstResponderWithFrame:(CGRect)toFrame duration:(NSTimeInterval)duration {
    
    [self adjustFirstResponderWithBy:CGRectGetMinY(toFrame) duration:duration];
}

- (void)adjustFirstResponderWithBy:(CGFloat)bottomY duration:(NSTimeInterval)duration {
    if (duration == 0) {
        self.view.bottom = bottomY;
    } else {
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.view.bottom = bottomY;
        } completion:nil];
    }
}

@end
