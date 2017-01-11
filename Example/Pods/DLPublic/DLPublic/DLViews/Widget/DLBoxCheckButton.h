//
//  DLBoxCheckButton.h
//  Chigo
//
//  Created by Jone on 30/11/2016.
//  Copyright © 2016 HangZhou DeLan Technology Co. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 左侧带有勾选框的按钮
 */
@interface DLBoxCheckButton : UIButton

@property (nonatomic, strong, nullable) UIImage *checkedImage;
@property (nonatomic, strong, nullable) UIImage *uncheckedImage;
@property (nonatomic, strong, readonly) UILabel *textLabel;

+ (instancetype)buttonWithType:(UIButtonType)buttonType UNAVAILABLE_ATTRIBUTE;

@end

NS_ASSUME_NONNULL_END
