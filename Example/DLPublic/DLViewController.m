//
//  DLViewController.m
//  DLPublic
//
//  Created by xfjiang on 07/15/2016.
//  Copyright (c) 2016 HangZhou DeLan Technology Co. All rights reserved.
//

#import "DLViewController.h"
#import <DLPublic/DLPublic.h>

@interface DLViewController ()

@end

@implementation DLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [DLErrorParser parseErrorCode:33];
}

- (IBAction)showError:(id)sender {
    [self showErrorMessageWithCode:-11];
}

@end
