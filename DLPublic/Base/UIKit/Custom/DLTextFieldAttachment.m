//
//  DLTextFieldComponent.m
//  Chigo
//
//  Created by Jone on 30/11/2016.
//  Copyright © 2016 HangZhou DeLan Technology Co. All rights reserved.
//

#import "DLTextFieldAttachment.h"
#import <DLPublic/UIView+Public.h>
#import "DLTextField.h"

@interface DLTextFieldAttachment()

@property (nonatomic, retain, readwrite) UILabel *label;
@property (nonatomic, retain, readwrite) UIImageView *imageView;
@property (nonatomic, retain, readwrite) DLTextField *textField;
@property (nonatomic, retain, readwrite) UIImageView *backgroudImageView;
@property (nonatomic, retain, readwrite) UIButton *eyesButton;

@end

@implementation DLTextFieldAttachment

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    [self setup];

    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;
    
    [self setup];
    
    return self;
}

#pragma mark -

- (void)setDisplayLeftIcon:(BOOL)displayLeftIcon {
    _displayLeftIcon = displayLeftIcon;
    [self layout];
}

- (void)setType:(DLTextFieldAttachmentType)type {
    _type = type;
    [self layout];
}

- (void)setTextSecurityWithHidden:(UIImage *)hiddenIcon dispalyed:(UIImage *)dispalyedIcon; {
    if (!hiddenIcon || !dispalyedIcon) return;
    _textField.secureTextEntry = YES;
    [_eyesButton setImage:hiddenIcon forState:UIControlStateNormal];
    [_eyesButton setImage:dispalyedIcon forState:UIControlStateSelected];
    _eyesButton.enabled = YES;
}

#pragma mark - 

- (void)eyesButtonOnTouched:(UIButton *)eyesButton {
    _textField.secureTextEntry = eyesButton.selected;
    eyesButton.selected = !eyesButton.selected;
}

- (void)setup {
    
    _label = [[UILabel alloc] init];
    [self addSubview:_label];
    _label.size = (CGSize){44, self.height};

    _imageView = [[UIImageView alloc] init];
    [self addSubview:_imageView];
    
    _textField = [[DLTextField alloc] init];
    [self addSubview:_textField];
    
    _eyesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_eyesButton addTarget:self action:@selector(eyesButtonOnTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_eyesButton];
    _eyesButton.enabled = NO;
    
    _backgroudImageView = [[UIImageView alloc] init];
    [self insertSubview:_backgroudImageView atIndex:0];
    
    self.displayLeftIcon = YES;
}

- (void)layout {
    _backgroudImageView.frame = self.bounds;

    CGFloat offset = 8.0;

    _textField.height = self.height;
    _textField.centerY = self.height / 2;
    
    _eyesButton.size = (CGSize){30, self.height};
    _eyesButton.right = self.width - 8;
    _eyesButton.centerY = self.height / 2;

    switch (_type) {
        case DLTextFieldAttachmentTypeImage: {
            _displayLeftIcon = YES;
            _label.hidden = YES;
            
            CGFloat imageSize = _displayLeftIcon ? 26 : 0;
            _imageView.size = (CGSize){imageSize, imageSize};
            _imageView.left = offset;
            _imageView.centerY = self.height / 2;
            _imageView.hidden = NO;
            
            _textField.width = self.width - _imageView.right;
            _textField.left = _imageView.width;
            
        } break;
        case DLTextFieldAttachmentTypeText: {
            _displayLeftIcon = NO;
            _imageView.hidden = YES;
            
            _label.left = offset;
            _label.centerY = self.height / 2;
            _label.hidden = NO;
            
            _textField.left = _label.width;
            _textField.width = self.width - _label.width;
        } break;
    }
    
}

- (void)sizeToFit {
    switch (_type) {
        case DLTextFieldAttachmentTypeImage: {
        } break;
            
        case DLTextFieldAttachmentTypeText: {
            [_label sizeToFit];
            _label.left = 8;
            _label.centerY = self.height / 2;
            _textField.width = self.width - _label.width;
            _textField.left = _label.width;
            
        } break;
    }
}

@end
