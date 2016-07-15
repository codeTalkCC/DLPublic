//
//  DLLocationManager.m
//  Pods
//
//  Created by DeLan on 16/7/15.
//  Copyright © 2016年 HangZhou DeLan Technology Co. All rights reserved.
//

#import "DLLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface DLLocation : NSObject
@property (nonatomic) NSString *province;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *district;
- (instancetype)initLocationWithProvince:(NSString *)province
                                    city:(NSString *)city
                                district:(NSString *)district;
@end

@implementation DLLocation
- (instancetype)initLocationWithProvince:(NSString *)province
                                    city:(NSString *)city
                                district:(NSString *)district {
    self = [super init];
    if (self) {
        _province = province;
        _city     = city;
        _district = district;
    }
    return self;
}

@end

typedef void (^DLLocationInfoBlock)(DLLocation *location, NSError *error);

@interface DLLocationManager()
@property (nonatomic, copy) DLLocationInfoBlock infoBlock;
@end

@implementation DLLocationManager {
    CLLocationManager *_locationManager;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"DLLocationManager init error" reason:@"defaultManager' to get instance." userInfo:nil];
    return [super init];
}

- (instancetype)_init {
    self = [super init];
    if (!self) return nil;
    _locationManager = [CLLocationManager new];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.delegate = self;
    if ([[UIDevice currentDevice] systemVersion].doubleValue >= 8) {
        [_locationManager requestWhenInUseAuthorization];
    }
}

+ (instancetype)defaultManager {
    static DLLocationManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] _init];
    });
    return manager;
}

- (void)startUpdatingLocation:(void (^)(DLLocation *location, NSError *error))locationInfo {
    _infoBlock = locationInfo;
    [self _startUpdateLocation];
}

- (void)_startUpdateLocation
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [_locationManager startUpdatingLocation];
}

- (void)_stopUpdateLocation
{
    [_locationManager stopUpdatingLocation];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {
    if (locations.count > 0) {
        CLLocation *location = locations[0];
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            
            [self _stopUpdateLocation];
            if (!error) {
                if (_infoBlock) {
                    _infoBlock(nil, error);
                }
            } else if (placemarks.count > 0) {
                CLPlacemark *placemark = placemarks[0];
                NSString *province = placemark.addressDictionary[@"State"];
                NSString *city     = placemark.addressDictionary[@"City"];
                NSString *district = placemark.addressDictionary[@"SubLocality"];
                if (province && city && district) {
                    DLLocation *dlLocation = [[DLLocation alloc] initLocationWithProvince:province
                                                                                     city:city
                                                                                 district:district];
                    if (_infoBlock) _infoBlock(dlLocation, nil);
                } else {
                    NSError *error = [NSError errorWithDomain:@"com.domain.public" code:1000 userInfo:nil];
                    if (_infoBlock) _infoBlock(nil, error);
                }
            }
        }];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (_infoBlock) _infoBlock(nil, error);
}
@end