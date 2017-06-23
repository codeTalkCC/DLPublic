//
//  DLDatePopupView.h
//  Chigo
//
//  Created by Jone on 23/12/2016.
//  Copyright © 2016 HangZhou DeLan Technology Co. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLDatePickerView : UIView

+ (instancetype)popup;

#pragma mark - 供定制化需求
@property (strong, nonatomic) UIButton *cancelButton; //取消按钮
@property (strong, nonatomic) UIButton *confimButton; //确定按钮
@property (strong, nonatomic) UIPickerView *adressPickerView;  //地址选择器

- (void)showWithBlock:(void (^)(NSDate * __nonnull selectedDate))resultBlock;

@property (nonatomic, strong, readwrite) UIDatePicker *datePicker;
@end

NS_ASSUME_NONNULL_END
