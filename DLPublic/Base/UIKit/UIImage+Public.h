//
//  UIImage+Public.h
//  DLPublicDemo
//
//  Created by DeLan on 16/7/12.
//  Copyright © 2016年 DeLan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Public)

/**
 *  Create and return a 1x1 point size image with the given color.
 *
 *  @param color The color
 */

+ (UIImage *)dl_imageWithColor:(UIColor *)color;

/**
 *  Create and retuurn a pure color image with the given color and size
 *
 *  @param color The color
 *  @param size  image size
 */
+ (UIImage *)dl_imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 Tint the image in alpha channel with the given color.
 
 @param color  The color.
 */
- (nullable UIImage *)dl_imageByTintColor:(UIColor *)color;

/**
 Returns a new image which is scaled from this image.
 The image will be stretched as needed.
 
 @param size  The new size to be scaled, values should be positive.
 
 @return      The new image with the given size.
 */
- (nullable UIImage *)dl_imageByResizeToSize:(CGSize)size;


/**
 Rounds a new image with a given corner size.
 
 @param radius  The radius of each corner oval. Values larger than half the
 rectangle's width or height are clamped appropriately to half
 the width or height.
 */
- (nullable UIImage *)dl_imageByRoundCornerRadius:(CGFloat)radius;

/**
 Rounds a new image with a given corner size.
 
 @param radius       The radius of each corner oval. Values larger than half the
 rectangle's width or height are clamped appropriately to
 half the width or height.
 
 @param borderWidth  The inset border line width. Values larger than half the rectangle's
 width or height are clamped appropriately to half the width
 or height.
 
 @param borderColor  The border stroke color. nil means clear color.
 */
- (nullable UIImage *)dl_imageByRoundCornerRadius:(CGFloat)radius
                                      borderWidth:(CGFloat)borderWidth
                                      borderColor:(nullable UIColor *)borderColor;

/**
 Rounds a new image with a given corner size.
 
 @param radius       The radius of each corner oval. Values larger than half the
 rectangle's width or height are clamped appropriately to
 half the width or height.
 
 @param corners      A bitmask value that identifies the corners that you want
 rounded. You can use this parameter to round only a subset
 of the corners of the rectangle.
 
 @param borderWidth  The inset border line width. Values larger than half the rectangle's
 width or height are clamped appropriately to half the width
 or height.
 
 @param borderColor  The border stroke color. nil means clear color.
 
 @param borderLineJoin The border line join.
 */
- (nullable UIImage *)dl_imageByRoundCornerRadius:(CGFloat)radius
                                          corners:(UIRectCorner)corners
                                      borderWidth:(CGFloat)borderWidth
                                      borderColor:(nullable UIColor *)borderColor
                                   borderLineJoin:(CGLineJoin)borderLineJoin;


/**
 Whether this image has alpha channel.
 */
- (BOOL)dl_hasAlphaChannel;

@end

NS_ASSUME_NONNULL_END