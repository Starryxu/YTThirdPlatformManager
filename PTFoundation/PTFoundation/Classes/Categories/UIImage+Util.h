//
//  UIImage+Util.h
//  MobileExperience
//
//  Created by fuyongle on 14-5-28.
//  Copyright (c) 2014年 NetDragon. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPlaceholderHorizontal      @"placeholder_horizontal"
#define kPlaceholderVertical        @"placeholder_vertical"

typedef enum {
    UIImageRoundedCornerTopLeft = 1,
    UIImageRoundedCornerTopRight = 1 << 1,
    UIImageRoundedCornerBottomRight = 1 << 2,
    UIImageRoundedCornerBottomLeft = 1 << 3,
    UIImageRoundedCornerAll = 0x0f,
} UIImageRoundedCorner;

@interface UIImage (Util)

+ (UIImage *)captureImage:(UIView *)view;                           //view快照

+ (UIImage *)imageWithColor:(UIColor *)color;                       //纯颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color withSize:(CGSize)size;

+ (UIImage *)placeholderImageWithSize:(CGSize)size
                           imageNamed:(NSString *)imageNamed
                            fillColor:(UIColor *)fillColor;
+ (UIImage *)placeholderImageNamed:(NSString *)imageName
                              size:(CGSize)size
                  imageSizePercent:(CGFloat)percent;
+ (UIImage *)grayscaleImageForImage:(UIImage *)image;               //生成黑白图片

- (UIImage *)imageWithRoundedRectWithRadius:(float)radius cornerMask:(UIImageRoundedCorner)cornerMask;
- (UIImage *)imageWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle;
- (UIImage *)imageWithGrayScale;
- (UIImage *)scaletoScale:(float)scaleSize;
- (UIImage *)scaletoSize:(float)imageSize;
- (UIImage *)scaletoWidth:(float)destWmageWidth;
- (UIImage *)scaletoSizeRect:(CGSize)imageSize;
- (UIImage *)imageWithRect:(CGRect)rect;
- (UIImage *)addImage:(UIImage *)image;
- (UIImage *)addImage:(UIImage *)image frame:(CGRect)frame;
- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;

@end
