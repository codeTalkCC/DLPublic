//
//  UINavigationController+Public.h
//  DLPublicDemo
//
//  Created by Delan on 16/7/12.
//  Copyright © 2016年 DeLan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Provides extension for `UINavigationController`.
 */
@interface UINavigationController (Public)

///=============================================================================
/// @name View Controlelr
///=============================================================================

/**
 Gets view controller with a given class.
 */
- (nullable UIViewController *)traverseViewController:(nonnull Class)vClass;

/**
 Gets root view controller.
 */
- (nullable UIViewController *)rootViewController;

/**
 Gets top view controller.
 */
- (nullable UIViewController *)topViewController;

/**
 Whether only have single root view controller.
 */
- (BOOL)singleViewController;

/**
 Gets view controllers count in navigation controller.
 */
- (NSUInteger)controllersCount;

#pragma mark - Stack Manager
///=============================================================================
/// @name Stack Manager
///=============================================================================

/**
 Pops view controllers until the one specified is on top. Returns the popped controllers.
 */
- (nullable NSArray<__kindof UIViewController *> *)popToViewControllerClass:(nonnull Class)vClass animated:(BOOL)animated;

/**
 Pops view controllers until count equal to `level`. Returns the popped controllers.
 
 @return level number of view controllers to pop.
 */
- (nullable NSArray<__kindof UIViewController *> *)popToViewControllerBackLevel:(NSUInteger)level animated:(BOOL)animated;

/**
 Pushes to view controller with identifier in same storyboard.
 */
- (void)pushViewControllerWithIdentifier:(NSString *)identifier;

/**
 Pushes to view controller with specified identifier which contained in stroybaord. animated.
 
 @param identifier  The specified view controller identifier.
 @param name        The storyboard name.
 */
- (void)pushViewControllerWithIdentifier:(NSString *)identifier storyboardName:(NSString *)name;

/**
 Pushes to view controller with specified identifier which contained in stroybaord.
 
 @param identifier  The specified view controller identifier.
 @param name        The storyboard name.
 @param animated    Whether animated when push.
 */
- (void)pushViewControllerWithIdentifier:(NSString *)identifier storyboardName:(NSString *)name animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
