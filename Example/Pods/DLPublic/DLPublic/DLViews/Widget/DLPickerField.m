//
//  DLPickerField.m
//  Chigo
//
//  Created by Jone on 23/12/2016.
//  Copyright © 2016 HangZhou DeLan Technology Co. All rights reserved.
//

#import "DLPickerField.h"
#import "DLTextField.h"

@interface DLPickerField ()
@property (nonatomic, strong) DLTextField *textField;
@property (nonatomic, strong) UIButton *pickerButton;
@end

@implementation DLPickerField
- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    [self setUp];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self setUp];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;
    [self setUp];
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        _textField.frame = self.bounds;
        _pickerButton.frame = (CGRect){CGRectGetWidth(self.bounds) - 44,
            0, 44, CGRectGetHeight(self.bounds)};
    }
}

- (void)setPickerIcon:(UIImage *)pickerIcon {
    [_pickerButton setImage:pickerIcon forState:UIControlStateNormal];
    _pickerIcon = pickerIcon;
}

- (void)setBackground:(UIImage *)background {
    _textField.background = background;
    _background = background;
}

- (void)pickerButtonOnTouched:(id)sender {
    if ([_delegate respondsToSelector:@selector(pickerFieldTapped:)]) {
        [_delegate pickerFieldTapped:self];
    }
}

- (void)setUp {
    _textField = [[DLTextField alloc] init];
    _textField.enabled = NO;
    [self addSubview:_textField];
    
    _pickerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_pickerButton setImage:[UIImage imageNamed:@"share_picker_icon"] forState:UIControlStateNormal];
    [_pickerButton addTarget:self action:@selector(pickerButtonOnTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_pickerButton];

}

@end
