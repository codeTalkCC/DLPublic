//
//  DLTestViewController.m
//  DLPublic
//
//  Created by Jone on 16/7/18.
//  Copyright © 2016年 HangZhou DeLan Technology Co. All rights reserved.
//

#import "DLTestViewController.h"

@interface DLTestViewController ()

@end

@implementation DLTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sho:(id)sender {
    
    [self showErrorMessageWithCode:-1];
//    
//    [self showHUDInteractionEable:YES];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8ull * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self hideHUD];
//    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
