//
//  DLLocalizableStandard.m
//  Chigo
//
//  Created by Jone on 29/11/2016.
//  Copyright © 2016 HangZhou DeLan Technology Co. All rights reserved.
//

#import "DLLocalizableStandard.h"



static NSBundle *_bundle;
static NSString *const kUserLanguage = @"kUserLanguage";

@implementation DLLocalizableStandard

+ (instancetype)sharedStandard {
    static DLLocalizableStandard *standard;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        standard = [[DLLocalizableStandard alloc] init];
    });
    return standard;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        if (!_bundle) {
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            NSString *userLanguage = [userDefault valueForKey:kUserLanguage];
         
            // 若未设置过语言
            if (userLanguage.length == 0) {
                NSArray *languages = [[NSBundle mainBundle] preferredLocalizations];
                NSString *systemLanguage = languages.firstObject;
                userLanguage = systemLanguage;
            }
            
            NSString *path = [[NSBundle mainBundle] pathForResource:userLanguage ofType:@"lproj"];
            _bundle = [NSBundle bundleWithPath:path];
        }
    }
    return self;
}

- (NSBundle *)bundle {
    return _bundle;
}

- (NSString *)currentLanguage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userLanguage = [defaults valueForKey:kUserLanguage];
    
    if (userLanguage.length == 0) {
        NSArray *languages = [[NSBundle mainBundle] preferredLocalizations];
        NSString *systemLanguage = languages.firstObject;
        return systemLanguage;
    }
    return userLanguage;
}

- (void)setUserlanguage:(NSString *)language {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    _bundle = [NSBundle bundleWithPath:path];
    
    [defaults setValue:language forKey:kUserLanguage];
}

- (NSString *)stringWithKey:(NSString *)key {
    if (_bundle) {
        return [_bundle localizedStringForKey:key value:nil table:@"DLLocalizable"];
    }else {
        return NSLocalizedString(key, nil);
    }
}
@end
