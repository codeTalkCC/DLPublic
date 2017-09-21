//
//  DLAdressPickerView.m
//  SmartLife
//
//  Created by ZejianCai on 2017/6/22.
//  Copyright © 2017年 xllin. All rights reserved.
//

#import "DLAdressPickerView.h"

static const CGFloat kAdressPickerHeight = 216;
static const CGFloat kAnimationDuration = 0.3;
static const CGFloat kAnimationDistance = 266;

static NSDictionary *provinceToCityDic;    //省名称：城市列表
static NSArray *provinceNameArray;          //为了记录顺序



@interface DLAdressPickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) NSString *selectedProvince;
@property (strong, nonatomic) NSString *selectedCity;
@property (strong, nonatomic) NSString *selectedDistrict;

@property (strong, nonatomic) void (^okBlock)(NSString *province,NSString *city, NSString *district);

@property (nonatomic, strong) UIView *contentView;

@end

@implementation DLAdressPickerView

+ (instancetype)popup {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [self initWithFrame:CGRectZero];
    if (!self) return nil;
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    frame = [[UIScreen mainScreen] bounds];
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self loadData];
    [self setBaseUI];
    return self;
}

- (UIPickerView *)adressPickerView{
    if (!_adressPickerView) {
        _adressPickerView = [[UIPickerView alloc]init];
        _adressPickerView.dataSource = self;
        _adressPickerView.delegate = self;
        _adressPickerView.frame = CGRectMake(0, 50, CGRectGetWidth(self.frame), kAdressPickerHeight);
    }
    return _adressPickerView;
}

#pragma 省市县的数据切换

- (void)loadData{
    if (!provinceToCityDic) {
        NSBundle *bundle = [NSBundle bundleForClass:[DLAdressPickerView class]];
        NSURL *url = [bundle URLForResource:@"DLPublic" withExtension:@"bundle"];
        NSBundle *addressBundle = [NSBundle bundleWithURL:url];
        NSString *plistPath = [addressBundle pathForResource:@"Address" ofType:@"plist"];
        NSArray *provinceArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
        //数据结构重构
        NSMutableDictionary *provinceNameToCitysDic = [[NSMutableDictionary alloc]init];
        NSMutableArray *provinceArrayTemp = [[NSMutableArray alloc]init];
        [provinceArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSDictionary *dic = (NSDictionary *)obj;
            NSString *provinceName = dic[@"province"];
            NSArray *citys = dic[@"citys"];
            NSMutableDictionary *cityNameToDistrictsDic = [[NSMutableDictionary alloc]init];
            for (NSDictionary *cityDic in citys) {
                NSString *cityName = cityDic[@"city"];
                NSArray *districts = cityDic[@"districts"];
                [cityNameToDistrictsDic setObject:districts forKey:cityName];
            }
            [provinceNameToCitysDic setObject:cityNameToDistrictsDic forKey:provinceName];
            [provinceArrayTemp addObject:provinceName];
            NSLog(@"省名称:%@",provinceName);
        }];
        provinceNameArray = (NSArray *)provinceArrayTemp;
        provinceToCityDic = (NSDictionary *)provinceNameToCitysDic;
    }
    _selectedProvince = [self provinceArray].firstObject;
    _selectedCity = [self cityArrayWithProvince:_selectedProvince].firstObject;
    _selectedDistrict = [self districtArrayWithCity:_selectedCity andProvince:_selectedProvince].firstObject;
}

//- (NSDictionary *)sortTheProvinceToCityDic:(NSDictionary *)allDic withSortedProvinceArray:(NSArray *)provinces{
//    NSMutableDictionary *resultDic = [[NSMutableDictionary alloc]init];
//    NSMutableArray *originProvinces = [[NSMutableArray alloc]initWithArray:allDic.allKeys];
//    
//    for (NSString *province in provinces) {
//        BOOL haveFind = NO;
//        NSString *originProvinceFinded = nil;
//        for (NSString *originProvince in originProvinces) {
//            if ([originProvince isEqualToString:province]) {
//                haveFind = YES;
//                NSArray *theArray = allDic[province];
//                [resultDic setObject:theArray forKey:province];
//                originProvinceFinded = originProvince;
//                break;
//            }
//        }
//        if (haveFind) {
//            [originProvinces removeObject:originProvinceFinded];
//        }
//    }
//    if (originProvinces.count == 0) {
//        NSLog(@"sort ok");
//    }else{
//        NSLog(@"sort failure");
//    }
//    return (NSDictionary *)resultDic;
//}

- (NSArray *)provinceArray{
    return provinceNameArray;
}
- (NSArray *)cityArrayWithProvince:(NSString *)province{
    NSDictionary *cityDic = provinceToCityDic[province];
    return cityDic.allKeys;
}

- (NSArray*)districtArrayWithCity:(NSString *)city andProvince:(NSString *)province{
    NSDictionary *cityDic = provinceToCityDic[province];
    return cityDic[city];
}

#pragma mark - UIChange
- (void)setBaseUI{
    CGRect frame = (CGRect){0, CGRectGetHeight(self.bounds),CGRectGetWidth(self.bounds),kAdressPickerHeight + 50};
    UIView *contentView = [[UIView alloc] initWithFrame:frame];
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    _contentView = contentView;
    
    //取消
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    UIColor *cancelColor = [UIColor colorWithRed:14/255.0 green:154/255.0 blue:242/255.0 alpha:1.0];
    [cancelButton setTitleColor:cancelColor forState:UIControlStateNormal];
    [cancelButton sizeToFit];
    CGRect cancelFrame = cancelButton.frame;
    cancelFrame.origin.y = 8;
    cancelFrame.origin.x = 16;
    cancelButton.frame = cancelFrame;
    [cancelButton addTarget:self action:@selector(cancelButtonOnTouched:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:cancelButton];
    _cancelButton = cancelButton;
    
    //确定
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    UIColor *confirmColor = [UIColor colorWithRed:14/255.0 green:154/255.0 blue:242/255.0 alpha:1.0];
    [confirmButton setTitleColor:confirmColor forState:UIControlStateNormal];
    [confirmButton sizeToFit];
    CGRect confirmFrame = confirmButton.frame;
    confirmFrame.origin.y = 8;
    confirmFrame.origin.x = CGRectGetWidth(self.frame) - 16 - CGRectGetWidth(confirmButton.frame);
    confirmButton.frame = confirmFrame;
    [confirmButton addTarget:self action:@selector(confirmButtonOnTouched:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:confirmButton];
    [contentView addSubview:self.adressPickerView];
    _confimButton = confirmButton;
    
    //横线
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 49, self.bounds.size.width, 1)];
    label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [contentView addSubview:label];
    
    //pickerView
    [_contentView addSubview:_adressPickerView];
    self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
}


- (void)hide {
    CGRect frame = _contentView.frame;
    frame.origin.y = self.frame.size.height;
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _contentView.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)cancelButtonOnTouched:(id)sender {
    [self hide];
}

- (void)confirmButtonOnTouched:(id)sender {
    if (_okBlock) {
        _okBlock(_selectedProvince,_selectedCity,_selectedDistrict);
    }
    [self hide];
}

#pragma mark - Method
- (NSString *)setValueWithProvince:(NSString *)province city:(NSString *)city disstrict:(NSString *)district{
    //查找省
    NSInteger provinceRow = 0;
    NSInteger cityRow = 0;
    NSInteger districtRow = 0;
    
    BOOL haveTheAddress = NO;
    for (NSString *theProvince in [self provinceArray]) {
        if ([theProvince isEqualToString:province]) {
            haveTheAddress = YES;
            _selectedProvince = province;
            provinceRow = [[self provinceArray]indexOfObject:theProvince];
            break;
        }
    }
    if (!haveTheAddress) {
        return @"无对应的省";
    }
    //查找市
    haveTheAddress = NO;
    NSArray *cityArray = [self cityArrayWithProvince:_selectedProvince];
    for (NSString *theCity in cityArray) {
        if ([theCity isEqualToString:city]) {
            haveTheAddress = YES;
            _selectedCity = city;
            cityRow = [cityArray indexOfObject:theCity];
            break;
        }
    }
    if (!haveTheAddress) {
        return @"当前省下无对应的城市";
    }
    //查找区和县
    haveTheAddress = NO;
    NSArray *districtArray = [self districtArrayWithCity:_selectedCity andProvince:_selectedProvince];
    for (NSString *theDistrict in districtArray) {
        if ([theDistrict isEqualToString:district]) {
            haveTheAddress = YES;
            _selectedDistrict = district;
            districtRow = [districtArray indexOfObject:theDistrict];
            break;
        }
    }
    if (!haveTheAddress) {
        return @"当前城市下无对应的区(县)";
    }
    //设置值
    [_adressPickerView reloadComponent:1];
    [_adressPickerView reloadComponent:2];
    [_adressPickerView selectRow:provinceRow inComponent:0 animated:YES];
    [_adressPickerView selectRow:cityRow inComponent:1 animated:YES];
    [_adressPickerView selectRow:districtRow inComponent:2 animated:YES];
    return nil;
}

- (void)showWithCompletion:(void (^)(NSString *, NSString *, NSString *))block{
    UIWindow *mainWindow = [[UIApplication sharedApplication].delegate window];
    [mainWindow addSubview:self];
    
    CGRect frame = _contentView.frame;
    frame.origin.y = CGRectGetHeight(self.bounds) - kAnimationDistance;
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _contentView.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
    _okBlock = block;
}



#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray *array = nil;
    switch (component) {
        case 0:
            array = [self provinceArray];
            break;
        case 1:
            array = [self cityArrayWithProvince:_selectedProvince];
            break;
        case 2:
            array = [self districtArrayWithCity:_selectedCity andProvince:_selectedProvince];
            break;
        default:
            return 0;
            break;
    }
    return array.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray *array = nil;
    switch (component) {
        case 0:
            array = [self provinceArray];
            break;
        case 1:
            array = [self cityArrayWithProvince:_selectedProvince];
            break;
        case 2:
            array = [self districtArrayWithCity:_selectedCity andProvince:_selectedProvince];
            break;
        default:
            return @"错误";
            break;
    }
    NSString *string = array[row];
    return string;
}


#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component) {
        case 0:{
            NSString *theSelectedProvince = [self provinceArray][row];
            if (![theSelectedProvince isEqualToString:_selectedProvince]) {
                _selectedProvince = theSelectedProvince;
                _selectedCity = [self cityArrayWithProvince:_selectedProvince].firstObject;
                _selectedDistrict = [self districtArrayWithCity:_selectedCity andProvince:_selectedProvince].firstObject;
                [pickerView reloadComponent:1];
                [pickerView reloadComponent:2];
            }
        }
            break;
        case 1:{
            NSArray *cityArray = [self cityArrayWithProvince:_selectedProvince];
            NSString *city = cityArray[row];
            if (![city isEqualToString:_selectedCity]) {
                _selectedCity = cityArray[row];
                _selectedDistrict = [self districtArrayWithCity:_selectedCity andProvince:_selectedProvince].firstObject;
                [pickerView reloadComponent:2];
            }
        }
            break;
        case 2:{
            NSArray *districtArray = [self districtArrayWithCity:_selectedCity andProvince:_selectedProvince];
            NSString *district = districtArray[row];
            _selectedDistrict = district;
        }
            break;
            
        default:
            break;
    }
}

@end
