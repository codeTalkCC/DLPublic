//
//  DLLocationManager.m
//  Pods
//
//  Created by DeLan on 16/7/15.
//  Copyright © 2016年 HangZhou DeLan Technology Co. All rights reserved.
//

#import "DLLocationManager.h"

@interface DLLocation()
//@property (nonatomic) NSString *province;
//@property (nonatomic) NSString *city;
//@property (nonatomic) NSString *district;
- (instancetype)initLocationWithProvince:(NSString *)province
                                    city:(NSString *)city
                                district:(NSString *)district
                               longitude:(CGFloat)longitude
                                latitude:(CGFloat)latitude
                                altitude:(CGFloat)altitude
                              postalCode:(NSString *)postalCode;
@end

@implementation DLLocation
- (instancetype)initLocationWithProvince:(NSString *)province
                                    city:(NSString *)city
                                district:(NSString *)district
                               longitude:(CGFloat)longitude
                                latitude:(CGFloat)latitude
                                altitude:(CGFloat)altitude
                              postalCode:(NSString *)postalCode;{
    self = [super init];
    if (self) {
        _province = province;
        _city     = city;
        _district = district;
        _longitude = longitude;
        _latitude = latitude;
        _altitude = altitude;
        _postalCode = postalCode;
    }
    return self;
}

@end

typedef void (^DLLocationInfoBlock)(DLLocation *location, NSError *error);
typedef void (^UpdatingLocationBlock)(NSArray<CLLocation *> *locations);

@interface DLLocationManager()<CLLocationManagerDelegate>

@property (nonatomic, copy) DLLocationInfoBlock infoBlock;
@property (nonatomic, copy) UpdatingLocationBlock updatingLocation;

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
    return self;
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
    [self startUpdateLocation];
}

- (void)startUpdationLoactionAccuracy:(CLLocationAccuracy)desiredAccuracy
                   didUpdateLocations:(void(^)(NSArray<CLLocation *> *locations))didUpdateBlock {
    _locationManager.desiredAccuracy = desiredAccuracy;
    _updatingLocation = didUpdateBlock;
}

- (void)startUpdateLocation
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [_locationManager startUpdatingLocation];
}

- (void)stopUpdateLocation
{
    [_locationManager stopUpdatingLocation];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {
    if (_updatingLocation) {
        _updatingLocation(locations);
    } else {
        if (locations.count > 0) {
            CLLocation *location = locations[0];
            //经纬度与高度
            CGFloat longitude = 0;
            CGFloat latitude = 0;
            CGFloat altitude = 0;
            if (location.horizontalAccuracy > 0) {
                NSLog(@"当前位置：%f,%f +/- %f meters", location.coordinate.longitude,
                      location.coordinate.latitude,
                      location.horizontalAccuracy);
                
                longitude = location.coordinate.longitude;
                latitude = location.coordinate.latitude;
            }
            
            if (location.verticalAccuracy > 0) {
                NSLog(@"当前高度：%f +/- %f meters", location.altitude, location.verticalAccuracy);
                
                altitude = location.altitude;
            }
            CLGeocoder *geocoder = [[CLGeocoder alloc] init];
            [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                
                [self stopUpdateLocation];
                
                if (error) {
                    if (_infoBlock) {
                        _infoBlock(nil, error);
                    }
                } else if (placemarks.count > 0) {
                    CLPlacemark *placemark = placemarks[0];
                    NSString *province = placemark.addressDictionary[@"State"];
                    NSString *city     = placemark.addressDictionary[@"City"];
                    NSString *district = placemark.addressDictionary[@"SubLocality"];
                    NSString *pastalCode = placemark.postalCode ? : @"";
                    if (province && city && district) {
                        DLLocation *dlLocation = [[DLLocation alloc] initLocationWithProvince:province city:city district:district longitude:longitude latitude:latitude altitude:altitude postalCode:pastalCode];
                        self.currentLocation = dlLocation;
                        if (_infoBlock) _infoBlock(dlLocation, nil);
                    } else {
                        NSError *error = [NSError errorWithDomain:@"com.domain.public" code:1000 userInfo:nil];
                        if (_infoBlock) _infoBlock(nil, error);
                    }
                }
            }];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (_infoBlock) _infoBlock(nil, error);
}
@end
