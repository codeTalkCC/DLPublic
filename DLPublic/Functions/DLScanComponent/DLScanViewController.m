//
//  DLScanViewController.m
//  DLSQCodeScan
//
//  Created by Jone on 15/10/27.
//  Copyright © 2015年 HangZhou DeLan Technology Co. All rights reserved.
//

#import "DLScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "QRView.h"


#define kDLSScreenWith    [UIScreen mainScreen].bounds.size.width
#define kDLSScreenHeight  [UIScreen mainScreen].bounds.size.height

static CGFloat kTransportScale = 0.7;
static const char * kQRCodeScanQueueName = "QRCodeScanQueueName";

@interface DLScanViewController ()<AVCaptureMetadataOutputObjectsDelegate, QRViewDelegate,UIAlertViewDelegate>

@property (nonatomic) AVCaptureDeviceInput *captureDeviceInput;
@property (nonatomic) AVCaptureMetadataOutput *captureMetadataOutput;
@property (nonatomic) AVCaptureSession *captureSession;
@property (nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@property (nonatomic) NSArray *metaTypeArray;

@property (nonatomic) QRView *qrView;

@property (nonatomic) UILabel *infoLabel; //提示信息label
@property (nonatomic) UILabel *openCloseLabel; //开启关闭灯光label
@property (nonatomic) UIImageView *openCloseImageView; //灯光开关的imageView
@property (nonatomic) UIImage *closeImage;  //关闭照片
@property (nonatomic) UIImage *openImage;   //开启照片
@end

@implementation DLScanViewController

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = NSLocalizedString(@"二维码扫描", @"STitleKey");
    
    [self configureSubViews];
    
    //灯光
    [self configureTorchButton];
    
    self.metaTypeArray = @[AVMetadataObjectTypeEAN13Code,
                           AVMetadataObjectTypeUPCECode,
                           AVMetadataObjectTypeCode39Code,
                           AVMetadataObjectTypeCode39Mod43Code,
                           AVMetadataObjectTypeEAN13Code,
                           AVMetadataObjectTypeEAN8Code,
                           AVMetadataObjectTypeCode128Code,
                           AVMetadataObjectTypeQRCode];
    
//    [self setup];
    [self startScan];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self stopScan];
}

- (void)viewWillLayoutSubviews
{
    [self updateLayout];
}

#pragma mark - Configure

- (void)configureSubViews
{
    _qrView = [[QRView alloc] initWithFrame:CGRectMake(0, 0, kDLSScreenWith, kDLSScreenHeight)];
    _qrView.transparentArea = CGSizeMake(kDLSScreenWith * kTransportScale, kDLSScreenWith * kTransportScale);
    _qrView.backgroundColor = [UIColor clearColor];
    _qrView.delegate = self;
    [self.view addSubview:_qrView];
    
    // 提示标签
    UILabel *promptLabel  = [[UILabel alloc] init];
    promptLabel.text      = [[NSBundle mainBundle] localizedStringForKey:@"将二维码放入框中, 即可自动扫描" value:nil table:@"Localizable"];
    promptLabel.font      = [UIFont systemFontOfSize:12.0];
    promptLabel.textColor = [UIColor whiteColor];
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.frame     = (CGRect){0, kDLSScreenHeight / 2 + kDLSScreenWith * kTransportScale / 2, kDLSScreenWith, 30};
    
    [_qrView addSubview:promptLabel];
    self.infoLabel = promptLabel;
}


/**
 闪光灯按钮
 */
- (void)configureTorchButton
{
    
    
    NSBundle *bundle = [NSBundle bundleForClass:[DLScanViewController class]];
    NSURL *url = [bundle URLForResource:@"DLPublic" withExtension:@"bundle"];
    if (url) {
        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
        self.openImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"dl_light_on" ofType:@"png"]];
        self.closeImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"dl_light_off" ofType:@"png"]];
        
        //容器button
        UIButton *contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat y = CGRectGetMaxY(self.infoLabel.frame) + 8;
        contentButton.frame      = CGRectMake((kDLSScreenWith - 64) / 2, y, 64, 150);
        contentButton.backgroundColor = [UIColor clearColor];
        [contentButton addTarget:self action:@selector(openTorchBtnOnTouched:) forControlEvents:UIControlEventTouchUpInside];
         [_qrView addSubview:contentButton];
        
        //图片button - 显示选中与非选中的图片
        self.openCloseImageView = [[UIImageView alloc]init];
        self.openCloseImageView.frame      = CGRectMake(0, 0, 64, 75);
        self.openCloseImageView.image = self.closeImage;
        self.openCloseImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.openCloseImageView.backgroundColor = [UIColor clearColor];
        [contentButton addSubview:self.openCloseImageView];
        
        // 提示标签打开 关闭
        UILabel *promptLabel  = [[UILabel alloc] init];
        promptLabel.text      = [[NSBundle mainBundle] localizedStringForKey:@"轻触照亮" value:nil table:@"Localizable"];
        promptLabel.font      = [UIFont systemFontOfSize:12.0];
        promptLabel.textColor = [UIColor whiteColor];
        promptLabel.textAlignment = NSTextAlignmentCenter;
        promptLabel.frame     = (CGRect){0, 72, 166, 30};
        CGPoint center = promptLabel.center;
        center.x = contentButton.frame.size.width / 2;
        promptLabel.center = center;
        [contentButton addSubview:promptLabel];
        self.openCloseLabel = promptLabel;
    }
}

#pragma mark - Setup

- (void)setup
{
    AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authorizationStatus) {
        case AVAuthorizationStatusNotDetermined: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler: ^(BOOL granted) {
                if (granted) {
                    [self startScan];
                } else {
                    NSLog(@"%@", @"访问受限");
                }
            }];
            break;
        }
            
        case AVAuthorizationStatusAuthorized: {
            [self startScan];
            break;
        }
            
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied: {
            NSLog(@"%@", @"访问受限");
            break;
        }
            
        default: {
            break;
        }
    }
    
}

#pragma mark -

- (void)startScan
{
    NSError * error;
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

    _captureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!_captureDeviceInput) {
        NSLog(@"无摄像头%@", [error localizedDescription]);
        //这这里进行出错处理
        [self showAlertWithMessage:[[NSBundle mainBundle]localizedStringForKey:@"请先开启相机权限" value:nil table:@"Localizable"]];
        return;
    }

    _captureSession = [[AVCaptureSession alloc] init];
    _captureSession.sessionPreset = AVCaptureSessionPresetHigh;
    if ([_captureSession canAddInput:_captureDeviceInput]) {
         [_captureSession addInput:_captureDeviceInput];
    }
   
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    if ([_captureSession canAddOutput:captureMetadataOutput]) {
        [_captureSession addOutput:captureMetadataOutput];
    }
    
    // 创建dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create(kQRCodeScanQueueName, NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    
    // 设置元数据类型 AVMetadataObjectTypeQRCode
    [captureMetadataOutput setMetadataObjectTypes:self.metaTypeArray];

    // 创建输出对象
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    _videoPreviewLayer.frame = [UIScreen mainScreen].bounds;
    _videoPreviewLayer.videoGravity = AVLayerVideoGravityResize;
    [self.view.layer insertSublayer:_videoPreviewLayer atIndex:0];
    
    // 开始会话
    [_captureSession startRunning];
}

- (void)stopScan
{
    [_captureSession stopRunning];
}

- (void)updateLayout
{
    _qrView.center = CGPointMake(kDLSScreenWith / 2, kDLSScreenHeight / 2);
    
    //修正扫描区域
    CGFloat screenHeight = self.view.frame.size.height;
    CGFloat screenWidth = self.view.frame.size.width;
    CGRect cropRect = CGRectMake((screenWidth - self.qrView.transparentArea.width) / 2,
                                 (screenHeight - self.qrView.transparentArea.height) / 2,
                                 self.qrView.transparentArea.width,
                                 self.qrView.transparentArea.height);
    
    [_captureMetadataOutput setRectOfInterest:CGRectMake(cropRect.origin.y / screenHeight,
                                          cropRect.origin.x / screenWidth,
                                          cropRect.size.height / screenHeight,
                                          cropRect.size.width / screenWidth)];
}


// 闪光灯
- (void)openTorchBtnOnTouched:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        if (sender.selected) {
            [device setTorchMode:AVCaptureTorchModeOn];
            self.openCloseLabel.text = [[NSBundle mainBundle] localizedStringForKey:@"轻触关闭" value:nil table:@"Localizable"];
            self.openCloseImageView.image = self.openImage;
        } else {
            [device setTorchMode:AVCaptureTorchModeOff];
            self.openCloseLabel.text = [[NSBundle mainBundle] localizedStringForKey:@"轻触照亮" value:nil table:@"Localizable"];
            self.openCloseImageView.image = self.closeImage;
        }
        [device unlockForConfiguration];
    }
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
      fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        [self stopScan];
        
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        NSString *result;
        NSString *metadataType = [metadataObj type];
        
        if ([self.metaTypeArray containsObject:metadataType]) {
            
            result = metadataObj.stringValue;
            
        } else {
            
            result = @"Sorry, No Scan Result";
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reportScanResult:result];
        });
//        [self performSelectorOnMainThread:@selector(reportScanResult:) withObject:result waitUntilDone:NO];
    }
}

#pragma mark - Scan Finish

- (void)reportScanResult:(NSString *)result
{
    [self playAudioServices];  // 播放音效
    [self.navigationController popViewControllerAnimated:YES];
    if ([_delegate respondsToSelector:@selector(scanViewController:didFinishScan:)]) {
        [_delegate scanViewController:self didFinishScan:result];
    }
}

#pragma mark - QRViewDelegate

- (void)scanTypeConfig:(QRItem *)item
{
    if (item.type == QRItemTypeQRCode) {
        _captureMetadataOutput.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
        
    } else if (item.type == QRItemTypeOther) {
        
        _captureMetadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code,
                                        AVMetadataObjectTypeEAN8Code,
                                        AVMetadataObjectTypeCode128Code,
                                        AVMetadataObjectTypeQRCode,
                                        AVMetadataObjectTypeQRCode];
    }
}

#pragma mark - Private Method

- (void)showAlertWithMessage:(NSString *)message
{
    NSString *msg = [NSString stringWithFormat:@"%@",message];
    UIAlertView *alerterView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:[[NSBundle mainBundle]localizedStringForKey:@"取消" value:nil table:@"Localizable"] otherButtonTitles:[[NSBundle mainBundle]localizedStringForKey:@"去设置" value:nil table:@"Localizable"], nil];
    alerterView.delegate = self;
    [alerterView show];
}

- (void)playAudioServices
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"dl_qrcode_found.wav" withExtension:nil];
    SystemSoundID soundID = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
    AudioServicesPlaySystemSound(soundID);
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        //跳转相机权限设置命令
        NSURL *cameralURL = [NSURL URLWithString:@"APP-Prefs:root=Privacy&path=CAMERA"];
        [[UIApplication sharedApplication] openURL:cameralURL options:[NSDictionary dictionary] completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"open cameraSetting sucess");
            }
        }];
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
