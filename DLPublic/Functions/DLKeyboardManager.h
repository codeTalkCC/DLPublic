//
//  DLKeyboardManager.h
//  DLPublicDemo
//
//  Created by DeLan on 16/7/13.
//  Copyright © 2016年 HangZhou DeLan Technology Co. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 System keyboard transition information.
 */
typedef struct {
    BOOL fromVisible; ///< Keyboard visible before transition.
    BOOL toVisible;   ///< Keyboard visible after transition.
    CGRect fromFrame; ///< Keyboard frame before transition.
    CGRect toFrame;   ///< Keyboard frame after transition.
    NSTimeInterval animationDuration;       ///< Keyboard transition animation duration.
    UIViewAnimationCurve animationCurve;    ///< Keyboard transition animation curve.
    UIViewAnimationOptions animationOption; ///< Keybaord transition animation option.
} DLKeyboardTransition;


/**
 The DLTextKeyboardObserver protocol defines the method you can use
 to receive system keyboard change information.
 */
@protocol DLKeyboardObserver <NSObject>
@optional
- (void)keyboardChangedWithTransition:(DLKeyboardTransition)transition;
@end



/**
 A DLKeyboardManager object lets you get the system keyboard information,
 and track the keyboard visible/frame/transition.
 
 @discussion You should access this class in main thread.
 */
@interface DLKeyboardManager : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

/// Get the default manager
+ (instancetype)defaultManager;

/// Get the keyboard window. nil if there's no keyboard window.
@property (nonnull, nonatomic, readonly) UIWindow *keyboardWindow;

/// Get the keyboard view. nil if there's no keyboard view.
@property (nonnull, nonatomic, readonly) UIView *keyboardView;

/// Whether the keyboard is visible
@property (nonatomic, readonly, getter=isKeyboardVisible) BOOL keyboardVisible;

/// Get the keyboard frame
/// Use convertRect:toView: to convert frame to specified view.
@property (nonatomic, readonly) CGRect keyboardFrame;

/**
 Add an observer to manager to get keyboard change information.
 This method makes a weak reference to the observer.
 
 @param observer An observer.
 This method will do nothing if the observer is nil, or already added.
 */
- (void)addObserver:(id<DLKeyboardObserver>)observer;

/**
 Remove an observer from manager.
 
 @param observer An observer.
 This method will do nothing if the observer is nil, or not in manager.
 */
- (void)removeObserver:(id<DLKeyboardObserver>)observer;

/**
 Convert rect to specified view or window.
 
 @param rect The frame rect.
 @param view A specified view or window (pass nil to convert for main window).
 @return The converted rect in specifeid view.
 */
- (CGRect)convertRect:(CGRect)rect toView:(nullable UIView *)view;

@end

NS_ASSUME_NONNULL_END