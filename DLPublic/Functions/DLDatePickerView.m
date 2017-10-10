//
//  DLDatePopupView.m
//  Chigo
//
//  Created by Jone on 23/12/2016.
//  Copyright © 2016 HangZhou DeLan Technology Co. All rights reserved.
//

#import "DLDatePickerView.h"

static const CGFloat kDatePickerHeight = 216;
static const CGFloat kAnimationDuration = 0.3;
static const CGFloat kAnimationDistance = 266;

@interface DLDatePickerView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) void (^resultBlock)(NSDate *date);;

@end

@implementation DLDatePickerView

+ (instancetype)popup {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [self initWithFrame:CGRectZero];
    if (!self) return nil;
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    frame = [[UIScreen mainScreen] bounds];
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self setUp];
    self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
    return self;
}


- (void)showWithBlock:(void (^)(NSDate * _Nonnull))resultBlock {
    UIWindow *mainWindow = [[UIApplication sharedApplication].delegate window];
    [mainWindow addSubview:self];
    
    CGRect frame = _contentView.frame;
    frame.origin.y -= kAnimationDistance;
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _contentView.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
    _resultBlock = resultBlock;
}

- (void)hide {
    CGRect frame = _contentView.frame;
    frame.origin.y = self.frame.size.height;
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _contentView.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)cancelButtonOnTouched:(id)sender {
    [self hide];
}

- (void)confirmButtonOnTouched:(id)sender {
    if (_resultBlock) {
        _resultBlock(_datePicker.date);
    }
    [self hide];
}

- (void)setUp {
    CGRect frame = (CGRect){0, CGRectGetHeight(self.bounds),CGRectGetWidth(self.bounds),kDatePickerHeight + 50};
    UIView *contentView = [[UIView alloc] initWithFrame:frame];
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    _contentView = contentView;
    
    //取消
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    UIColor *cancelColor = [UIColor colorWithRed:14/255.0 green:154/255.0 blue:242/255.0 alpha:1.0];
    [cancelButton setTitleColor:cancelColor forState:UIControlStateNormal];
    [cancelButton sizeToFit];
    CGRect cancelFrame = cancelButton.frame;
    cancelFrame.origin.y = 8;
    cancelFrame.origin.x = 16;
    cancelButton.frame = cancelFrame;
    [cancelButton addTarget:self action:@selector(cancelButtonOnTouched:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:cancelButton];
    _cancelButton = cancelButton;
    
    //确定
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    UIColor *confirmColor = [UIColor colorWithRed:14/255.0 green:154/255.0 blue:242/255.0 alpha:1.0];
    [confirmButton setTitleColor:confirmColor forState:UIControlStateNormal];
    [confirmButton sizeToFit];
    CGRect confirmFrame = confirmButton.frame;
    confirmFrame.origin.y = 8;
    confirmFrame.origin.x = CGRectGetWidth(self.frame) - 16 - CGRectGetWidth(confirmButton.frame);
    confirmButton.frame = confirmFrame;
    [confirmButton addTarget:self action:@selector(confirmButtonOnTouched:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:confirmButton];
    [contentView addSubview:self.adressPickerView];
    _confimButton = confirmButton;
    
    //横线
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 49, self.bounds.size.width, 1)];
    label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [contentView addSubview:label];
    
    //pickerView
    [_contentView addSubview:_adressPickerView];
    self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
    
    _datePicker = [UIDatePicker new];
    [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    _datePicker.frame = (CGRect){0, 50, CGRectGetWidth(self.bounds), kDatePickerHeight};
    _datePicker.datePickerMode = UIDatePickerModeDate;
    [contentView addSubview:_datePicker];
}

- (void)datePickerValueChanged:(UIDatePicker *)sender {
    NSDate *date = sender.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    _titleLabel.text = dateStr;
}

@end
