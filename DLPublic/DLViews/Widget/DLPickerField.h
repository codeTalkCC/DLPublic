//
//  DLPickerField.h
//  Chigo
//
//  Created by Jone on 23/12/2016.
//  Copyright © 2016 HangZhou DeLan Technology Co. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DLPickerField;
@protocol DLPickerFieldDelegate <NSObject>
- (void)pickerFieldTapped:(DLPickerField *)pickerField;
@end

@interface DLPickerField : UIView
@property (nullable, nonatomic, strong) UIImage *pickerIcon;
@property (nullable, nonatomic, strong) UIImage *background;
@property (nonnull, nonatomic, strong, readonly) UITextField *textField;
@property (nonatomic, weak) id<DLPickerFieldDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
