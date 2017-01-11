//
//  DLDatePopupView.h
//  Chigo
//
//  Created by Jone on 23/12/2016.
//  Copyright © 2016 HangZhou DeLan Technology Co. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLDatePopupView : UIView

@property (nonatomic, assign) UIDatePickerMode datePickerMode;

+ (instancetype)popup;
- (void)showWithBlock:(void (^)(NSDate * __nonnull selectedDate))resultBlock;

@end

NS_ASSUME_NONNULL_END
