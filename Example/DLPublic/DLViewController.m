//
//  DLViewController.m
//  DLPublic
//
//  Created by xfjiang on 07/15/2016.
//  Copyright (c) 2016 HangZhou DeLan Technology Co. All rights reserved.
//

#import "DLViewController.h"
#import <DLPublic/DLPublic.h>

static NSString *T_DLDatePickerView = @"T_DLDatePickerView";
static NSString *T_DLAddressPickerView = @"T_DLAddressPickerView";
static NSString *T_DLNetworkUtil = @"T_DLNetworkUtil";
static NSString *T_TextField = @"T_TextField";
static NSString *T_Camera = @"T_Camera";

@interface DLViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *testArray;

@end

@implementation DLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _testArray = @[T_DLDatePickerView,T_DLAddressPickerView,T_DLNetworkUtil,T_TextField,T_Camera];
    [self creatableView];
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)creatableView{
    _tableView = [[UITableView alloc]init];
    _tableView.tableFooterView = [UIView new];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.frame = self.view.bounds;
    [self.view addSubview:_tableView];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _testArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIndentifier = @"CellIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
    }
    NSString *functionString = _testArray[indexPath.row];
    NSString *title = functionString;
    cell.textLabel.text = title;
    if ([functionString isEqualToString:T_TextField]) {
        UITextField *textField = [[UITextField alloc]init];
        textField.frame = CGRectMake(111, 0, 100, 44);
        textField.backgroundColor = [UIColor grayColor];
        [cell.contentView addSubview:textField];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *functionString = _testArray[indexPath.row];
//    NSString *actionString = [NSString stringWithFormat:@"%@_Action",functionString];
    if ([functionString isEqualToString:T_DLDatePickerView]) {
        [self T_DLDatePickerView_Action];
    }
    if ([functionString isEqualToString:T_DLAddressPickerView]) {
        [self T_DLAddressPickerView_Avtion];
    }
    if ([functionString isEqualToString:T_DLNetworkUtil]) {
        [self T_DLNetworkUtil_Action];
    }
    if ([functionString isEqualToString:T_TextField]) {
        [self T_TextField_Action ];
    }
    if ([functionString isEqualToString:T_Camera]) {
        [self T_Camera_Action ];
    }
}


#pragma mark - ActionTest

/**
 T_DLDatePickerView_Action
 */
- (void)T_DLDatePickerView_Action{
    NSLog(@"test");
    DLDatePickerView *pickerView = [DLDatePickerView popup];
    [pickerView.confimButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [pickerView showWithBlock:^(NSDate * _Nonnull selectedDate) {
        NSLog(@"select date:%@",selectedDate);
    }];
}

- (void)T_DLAddressPickerView_Avtion{
    DLAdressPickerView *pickerView = [DLAdressPickerView popup];
    [pickerView showWithCompletion:^(NSString * _Nonnull province, NSString * _Nonnull city, NSString * _Nonnull district) {
        NSLog(@"%@%@%@",province,city,district);
    }];
}

- (void)T_DLNetworkUtil_Action{
    NSDictionary *dic = [DLNetworkUtil getWifiInfo];
    NSLog(@"%@",dic);
}

- (void)T_TextField_Action{
    
}

- (void)T_Camera_Action{
    DLScanViewController *targetVC = [[DLScanViewController alloc]init];
    [self.navigationController pushViewController:targetVC animated:YES];
}
@end
