//
//  DLAdressPickerView.h
//  SmartLife
//
//  Created by ZejianCai on 2017/6/22.
//  Copyright © 2017年 xllin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface DLAdressPickerView : UIView

+ (instancetype)popup;

#pragma mark - 供定制化需求
@property (strong, nonatomic) UIButton *cancelButton; //取消按钮
@property (strong, nonatomic) UIButton *confimButton; //确定按钮
@property (strong, nonatomic) UIPickerView *adressPickerView;  //地址选择器


/**
 设置值，也可以用于设置初始值

 @param province 省
 @param city 市
 @param district 区（县）
 @return 错误信息，如果为空则代表设置成功
 */
- (NSString *__nullable)setValueWithProvince:(NSString *)province city:(NSString *)city disstrict:(NSString *)district;


/**
 显示地址选择器

 @param block 用户点击确定时的操作
 */
- (void)showWithCompletion:(void (^)(NSString *province,NSString *city, NSString *district))block;


@end

NS_ASSUME_NONNULL_END
