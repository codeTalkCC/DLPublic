//
//  DLBoxCheckButton.m
//  Chigo
//
//  Created by Jone on 30/11/2016.
//  Copyright © 2016 HangZhou DeLan Technology Co. All rights reserved.
//

#import "DLBoxCheckButton.h"

static CGFloat const kButtonHeight = 30.0;
static CGFloat const kButtonFontSize = 14.0;

@interface DLBoxCheckButton()

@property (nonatomic, strong) UIButton *boxImageView;
@property (nonatomic, strong) UILabel *textLabel;

@end


@implementation DLBoxCheckButton

+ (instancetype)button {
    DLBoxCheckButton *boxCheckBtn = [[DLBoxCheckButton alloc] init];
    return boxCheckBtn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    frame.size.height = kButtonHeight;
    
    [self setup];
    
    return self;
}

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    CGRect frame = (CGRect){0, 0, 200, kButtonHeight};
    self.frame = frame;
    
    [self setup];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;
    
    [self setup];
    
    return self;
}

- (void)setup {
    
    _textLabel = [UILabel new];
    _textLabel.font = [UIFont systemFontOfSize:kButtonFontSize];
    CGRect textFrame = _textLabel.frame;
    textFrame = (CGRect){0, 0, self.frame.size};
    textFrame.origin.x = 23;
    _textLabel.frame = textFrame;
    [self addSubview:_textLabel];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return (CGRect){0, (self.frame.size.height - 14) / 2, 112, 14};
}

#pragma mark - Accesser

- (void)setCheckedImage:(UIImage *)checkedImage {
    _checkedImage = checkedImage;
    [self setImage:checkedImage forState:UIControlStateSelected];
}

- (void)setUncheckedImage:(UIImage *)uncheckedImage {
    _uncheckedImage = uncheckedImage;
    [self setImage:uncheckedImage forState:UIControlStateNormal];
}

@end
