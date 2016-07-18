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
    NSDate *yestoday = [NSDate dateWithTimeIntervalSinceNow:1 * 60*60*24];
    BOOL he = [yestoday isYesterday];
    NSLog(@"");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
