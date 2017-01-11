//
//  UIResponder+Public.m
//  DLPublicDemo
//
//  Created by DeLan on 16/7/14.
//  Copyright © 2016年 DeLan. All rights reserved.
//

#import "UIResponder+Public.h"

// Dummy class for category
@interface UIResponder_Public : NSObject @end
@implementation UIResponder_Public @end


@implementation UIResponder (Public)

static id __weak currentFristResponder;

- (id)currentFirstResponder {
    currentFristResponder = nil;
    BOOL isFind = [[UIApplication sharedApplication] sendAction:@selector(findFirstResponder:) to:nil from:nil forEvent:nil];
    return isFind ? currentFristResponder : nil;
}

- (void)findFirstResponder:(id)sender {
    currentFristResponder = self;
}

@end
