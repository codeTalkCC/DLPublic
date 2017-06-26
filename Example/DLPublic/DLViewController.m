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

@interface DLViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *testArray;

@end

@implementation DLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _testArray = @[T_DLDatePickerView,T_DLAddressPickerView];
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
    NSString *title = _testArray[indexPath.row];
    cell.textLabel.text = title;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *functionString = _testArray[indexPath.row];
    if ([functionString isEqualToString:T_DLDatePickerView]) {
        [self T_DLDatePickerView_Action];
    }
    if ([functionString isEqualToString:T_DLAddressPickerView]) {
        [self T_DLAddressPickerView_Avtion];
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
@end
