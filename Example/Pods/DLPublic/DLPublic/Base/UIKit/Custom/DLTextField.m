//
//  DLTextField.m
//  Chigo
//
//  Created by Jone on 29/11/2016.
//  Copyright © 2016 HangZhou DeLan Technology Co. All rights reserved.
//

#import "DLTextField.h"

@implementation DLTextField

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    NSString *placeholder = self.placeholder;
    if (!placeholderColor || !placeholder) return;
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName : placeholderColor}];
}

- (void)passwordKeyboard {
    self.keyboardType = UIKeyboardTypeASCIICapable;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.autocapitalizationType = UITextAutocorrectionTypeNo;
}

#pragma mark - Custom Bounds

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 16, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 16, 0);
}

@end
