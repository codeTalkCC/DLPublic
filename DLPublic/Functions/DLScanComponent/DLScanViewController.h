//
//  DLScanViewController.h
//  DLSQCodeScan
//
//  Created by Jone on 15/10/27.
//  Copyright © 2015年 HangZhou DeLan Technology Co. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^QRResultBlock) (NSString *result);

@class DLScanViewController;
@protocol DLScanViewControllerDelegate <NSObject>

- (void)scanViewController:(DLScanViewController *)scanViewController didFinishScan:(NSString *)scanResult;

@end


@interface DLScanViewController : UIViewController

@property (nonatomic, copy) QRResultBlock resultBlock;
@property (nonatomic, weak) id<DLScanViewControllerDelegate> delegate;

@end
