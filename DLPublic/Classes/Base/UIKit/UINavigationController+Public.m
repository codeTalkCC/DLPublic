//
//  UINavigationController+Public.m
//  DLPublicDemo
//
//  Created by Delan on 16/7/12.
//  Copyright © 2016年 DeLan. All rights reserved.
//

#import "UINavigationController+Public.h"

@implementation UINavigationController (Public)

- (nullable UIViewController *)dl_traverseViewController:(nonnull Class)vClass
{
    for (UIViewController *viewController in self.viewControllers) {
        if ([viewController isKindOfClass:vClass]) {
            return viewController;
        }
    }
    return nil;
}

- (BOOL)dl_singleViewController {
    if ([self dl_controllersCount] == 1) {
        return YES;
    } else {
        return NO;
    }
}

- (nullable UIViewController *)dl_rootViewController {
    if ([self dl_controllersCount] > 0) {
        return self.viewControllers.firstObject;
    } else {
        return nil;
    }
}

- (nullable UIViewController *)dl_topViewController {
    return self.viewControllers.lastObject;
}

- (NSUInteger)dl_controllersCount {
    return self.viewControllers.count;
}

- (nullable NSArray<__kindof UIViewController *> *)dl_popToViewController:(nonnull Class)vClass animated:(BOOL)animated {
    if ([[self dl_topViewController] isKindOfClass:vClass]) return nil;
    UIViewController *dst = [self dl_traverseViewController:vClass];
    if (dst) {
        return [self popToViewController:dst animated:animated];
    } else {
        return nil;
    }
}

- (nullable NSArray<__kindof UIViewController *> *)dl_popToViewControllerBackLevel:(NSUInteger)level animated:(BOOL)animated {
    if (level == 0) return nil;
    if ([self dl_controllersCount] > level) {
        NSInteger idx = [self dl_controllersCount] - level - 1;
        UIViewController *viewController = self.viewControllers[idx];
        return [self popToViewController:viewController animated:animated];
    } else {
        return [self popToRootViewControllerAnimated:animated];
    }
}

- (void)dl_pushViewControllerWithIdentifier:(NSString *)identifier {
    UIViewController *cur = [self dl_topViewController];
    UIViewController *dst = [cur.storyboard instantiateViewControllerWithIdentifier:identifier];
    if (dst) {
        [self pushViewController:dst animated:YES];
    }
}

- (void)dl_pushViewControllerWithIdentifier:(NSString *)identifier storyboardName:(NSString *)name {
    [self dl_pushViewControllerWithIdentifier:identifier storyboardName:name animated:YES];
}

- (void)dl_pushViewControllerWithIdentifier:(NSString *)identifier storyboardName:(NSString *)name animated:(BOOL)animated {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:name bundle:nil];
    UIViewController *dst = [sb instantiateViewControllerWithIdentifier:identifier];
    if (dst) {
        [self pushViewController:dst animated:animated];
    }
}
@end
