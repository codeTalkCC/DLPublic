//
//  DLTextField.h
//  Chigo
//
//  Created by Jone on 29/11/2016.
//  Copyright © 2016 HangZhou DeLan Technology Co. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLTextField : UITextField

@property (nullable, nonatomic, strong) UIColor *placeholderColor;

- (void)passwordKeyboard;

@end

NS_ASSUME_NONNULL_END
