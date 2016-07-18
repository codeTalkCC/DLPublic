//
//  DLViewController.m
//  DLPublic
//
//  Created by xfjiang on 07/15/2016.
//  Copyright (c) 2016 HangZhou DeLan Technology Co. All rights reserved.
//

#import "DLViewController.h"
#import <DLPublic/DLPublic.h>
#import <DLPublic/NSDate+Public.h>

@interface DLViewController ()

@end

@implementation DLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self parseErrorCode:-1];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nullable NSString *)parseErrorCode:(NSInteger)errCode {
    BOOL chinese = YES;
    NSString *fileName = chinese ? @"errorCode_cn" : @"errorCode_en";
    NSBundle *currentBundle = [NSBundle bundleForClass:self.class];
    NSURL *bundleURL = [currentBundle URLForResource:fileName withExtension:@"bundle"];
    NSBundle *xmlBundle = [NSBundle bundleWithURL:bundleURL];
    NSString *path = [xmlBundle pathForResource:fileName ofType:@"xml"];
    NSData *xmlData = [NSData dataWithContentsOfFile:path];
    NSDictionary *resultDic = [NSDictionary dictionaryWithXML:xmlData];
    NSArray *errDictArray = resultDic[@"error"];
    for (NSDictionary *itemDict in errDictArray) {
        NSString *code = itemDict[@"code"];
        if (code.integerValue == errCode) {
            return [NSString stringWithFormat:@"%@[%ld]", itemDict[@"text"], (long)errCode];
        }
    }
    NSString *unknow = chinese ? @"未知错误" : @"Unknow Error";
    return [NSString stringWithFormat:@"%@[%ld]", unknow, (long)errCode];
}

@end
