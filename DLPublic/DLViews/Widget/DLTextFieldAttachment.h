//
//  DLTextFieldComponent.h
//  Chigo
//
//  Created by Jone on 30/11/2016.
//  Copyright © 2016 HangZhou DeLan Technology Co. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DLTextField;

typedef NS_ENUM(NSUInteger, DLTextFieldAttachmentType) {
    DLTextFieldAttachmentTypeImage,   // 图片
    DLTextFieldAttachmentTypeText   // 文字
};

/**
 左侧带有可选图标，右侧带有可选查看文本按钮的 TextField
 
 左侧图标大小 {52, 52}.
 右侧图标大小 {38, 30}.
 */
@interface DLTextFieldAttachment : UIView

/** 是否显示左侧的图标，默认为 YES */
@property (nonatomic, assign) BOOL displayLeftIcon;

/** 左侧显示类型，默认显示图片 */
@property (nonatomic, assign) DLTextFieldAttachmentType type;

/** 左侧文字标签 */
@property (nonnull, nonatomic, readonly) UILabel *label;

/** 左侧图标视图，大小{26, 26}*/
@property (nonnull, nonatomic, readonly) UIImageView *imageView;

/** 输入框 */
@property (nonnull, nonatomic, readonly) DLTextField *textField;

/** 背景图片 */
@property (nonnull, nonatomic, readonly) UIImageView *backgroudImageView;

/**
 设置显示/隐藏文本内容图标
 设置会自动将输入框内容隐藏
 
 @param hiddenIcon 文本显示图标
 @param dispalyedIcon  文本隐藏图标
 */
- (void)setTextSecurityWithHidden:(nonnull UIImage *)hiddenIcon dispalyed:(nonnull UIImage *)dispalyedIcon;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@end

NS_ASSUME_NONNULL_END
