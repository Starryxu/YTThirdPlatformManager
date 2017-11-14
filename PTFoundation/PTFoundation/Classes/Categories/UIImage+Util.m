//
//  UIImage+Util.m
//  MobileExperience
//
//  Created by fuyongle on 14-5-28.
//  Copyright (c) 2014年 NetDragon. All rights reserved.
//

#import "UIImage+Util.h"
#import <objc/runtime.h>
#import <WebKit/WebKit.h>
#import "UtilMacro.h"

@implementation UIImage (Util)

//view快照
+ (UIImage *)captureImage:(UIView *)view
{
    CGSize size = view.bounds.size;
    size.width = MIN(size.width, kScreenWidth);
    size.height = MIN(size.height, kScreenHeight);
    
    BOOL containWKWebView = NO;
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[WKWebView class]]) {
            containWKWebView = YES;
        }
    }
    
    if (containWKWebView) {
        UIGraphicsBeginImageContextWithOptions(size, view.opaque, 0.0);
        for (UIView *subview in view.subviews) {
            [subview drawViewHierarchyInRect:subview.bounds afterScreenUpdates:YES];
        }
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img;
    } else {
        UIGraphicsBeginImageContextWithOptions(size, view.opaque, 0.0);
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img;
    }
}

// 生成指定大小的纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [UIImage imageWithColor:color withSize:CGSizeMake(1, 1)];
}

// 生成指定大小的纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color withSize:(CGSize)size
{
    UIImage *img = nil;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIImage *)placeholderImageWithSize:(CGSize)size
                           imageNamed:(NSString *)imageNamed
                            fillColor:(UIColor *)fillColor
{
    static NSMutableDictionary *imageDict;
    if (!imageDict) {
        imageDict = [[NSMutableDictionary alloc] init];
    }
    NSString *imageKey = [self imageKeyWithName:imageNamed size:size fillColor:fillColor];
    UIImage *cachedImage = [imageDict objectForKey:imageKey];
    if (cachedImage) {
        return cachedImage;
    } else {
        if (nil == imageNamed || imageNamed.length == 0) {
            imageNamed = @"default_icon_1024";
        }
        UIImage *createdImage = [[UIImage imageNamed:imageNamed] resizeImageWithNewSize:size percent:0.5f fillColor:fillColor];
        if (imageDict.count > 20) {
            [imageDict removeAllObjects];
        }
        [imageDict setObject:createdImage forKey:imageKey];
        return createdImage;
    }
}

+ (NSString *)imageKeyWithName:(NSString *)name size:(CGSize)size fillColor:(UIColor *)fillColor {
    NSInteger componentCount = 0;
    if (fillColor) {
        componentCount = CGColorGetNumberOfComponents(fillColor.CGColor);
    }
    if (componentCount >= 3) {
        const CGFloat *components = CGColorGetComponents(fillColor.CGColor);
        return [NSString stringWithFormat:@"%@_%0.0f_%0.0f_%f_%f_%f", validString(name), size.width, size.height, components[0], components[1], components[2]];
    } else {
        return [NSString stringWithFormat:@"%@_%0.0f_%0.0f", validString(name), size.width, size.height];
    }
}

+ (UIImage *)placeholderImageNamed:(NSString *)imageName
                              size:(CGSize)size
                  imageSizePercent:(CGFloat)percent
{
    return [[UIImage imageNamed:imageName] resizeImageWithNewSize:size percent:percent fillColor:nil];
}

- (UIImage *)imageWithColor:(UIColor *)color withSize:(CGSize)size imageSizePercent:(CGFloat)percent
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    CGFloat iconSize = percent* MIN(size.width, size.height);
    CGRect imageRect = CGRectMake((size.width - iconSize)/2, (size.height - iconSize)/2, iconSize, iconSize);
    CGContextDrawImage(context, imageRect, self.CGImage);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    // make a new UIImage to return
    UIImage *resultImage = [UIImage imageWithCGImage:imageRef scale:kScreenScale orientation:UIImageOrientationDown];
    
//    img = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRelease(imageRef);
    UIGraphicsEndImageContext();
    
    return resultImage;
}
//生成黑白图片
//zhouhong 用于生成黑白图片
- (UIImage*)imageWithGrayScale
{
    /* const UInt8 luminance = (red * 0.2126) + (green * 0.7152) + (blue * 0.0722); // Good luminance value */
    /// Create a gray bitmap context
    const size_t width = self.size.width * self.scale;
    const size_t height = self.size.height * self.scale;
    
    CGRect imageRect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8/*Bits per component*/, width * 3, colorSpace, 0);
    CGColorSpaceRelease(colorSpace);
    if (!bmContext)
        return nil;
    
    /// Image quality
    CGContextSetShouldAntialias(bmContext, false);
    CGContextSetInterpolationQuality(bmContext, kCGInterpolationHigh);
    
    /// Draw the image in the bitmap context
    CGContextDrawImage(bmContext, imageRect, self.CGImage);
    
    /// Create an image object from the context
    CGImageRef grayscaledImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage *grayscaled = [UIImage imageWithCGImage:grayscaledImageRef
                                              scale:self.scale
                                        orientation:self.imageOrientation];
    
    /// Cleanup
    CGImageRelease(grayscaledImageRef);
    CGContextRelease(bmContext);
    
    return grayscaled;
}

+ (UIImage *)grayscaleImageForImage:(UIImage *)image {
    // Adapted from this thread: http://stackoverflow.com/questions/1298867/convert-image-to-grayscale
    const int RED = 1;
    const int GREEN = 2;
    const int BLUE = 3;
    
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0, 0, image.size.width * image.scale, image.size.height * image.scale);
    
    int width = imageRect.size.width;
    int height = imageRect.size.height;
    
    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));
    
    // clear the pixels so any transparency is preserved
    memset(pixels, 0, width * height * sizeof(uint32_t));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    
    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [image CGImage]);
    
    for(int y = 0; y < height; y++) {
        for(int x = 0; x < width; x++) {
            uint8_t *rgbaPixel = (uint8_t *) &pixels[y * width + x];
            
            // convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
            uint32_t gray = 0.3 * rgbaPixel[RED] + 0.59 * rgbaPixel[GREEN] + 0.11 * rgbaPixel[BLUE];
            
            // set the pixels to gray
            rgbaPixel[RED] = gray;
            rgbaPixel[GREEN] = gray;
            rgbaPixel[BLUE] = gray;
        }
    }
    
    // create a new CGImageRef from our context with the modified pixels
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);
    
    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef
                                                 scale:image.scale
                                           orientation:UIImageOrientationUp];
    
    // we're done with image now too
    CGImageRelease(imageRef);
    
    return resultUIImage;
}

////////////////////////////////////////////////////////////////////////////////
//UIKit坐标系统原点在左上角，y方向向下的（坐标系A），但在Quartz中坐标系原点在左下角，y方向向上的(坐标系B)。图片绘制也是颠倒的。
static void addRoundedRectToPath(CGContextRef context, CGRect rect, float radius, UIImageRoundedCorner cornerMask)
{
    //原点在左下方，y方向向上。移动到线条2的起点。
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + radius);
    
    //画出线条2, 目前画线的起始点已经移动到线条2的结束地方了。
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height - radius);
    
    //如果左上角需要画圆角，画出一个弧线出来。
    if (cornerMask & UIImageRoundedCornerTopLeft) {
        
        //已左上的正方形的右下脚为圆心，半径为radius， 180度到90度画一个弧线，
        CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + rect.size.height - radius,
                        radius, M_PI, M_PI / 2, 1);
    }
    
    else {
        //如果不需要画左上角的弧度。从线2终点，画到线3的终点，
        CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height);
        
        //线3终点，画到线4的起点
        CGContextAddLineToPoint(context, rect.origin.x + radius, rect.origin.y + rect.size.height);
    }
    
    //画线4的起始，到线4的终点
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width - radius,
                            rect.origin.y + rect.size.height);
    
    //画右上角
    if (cornerMask & UIImageRoundedCornerTopRight) {
        CGContextAddArc(context, rect.origin.x + rect.size.width - radius,
                        rect.origin.y + rect.size.height - radius, radius, M_PI / 2, 0.0f, 1);
    }
    else {
        CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
        CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height - radius);
    }
    
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + radius);
    
    //画右下角弧线
    if (cornerMask & UIImageRoundedCornerBottomRight) {
        CGContextAddArc(context, rect.origin.x + rect.size.width - radius, rect.origin.y + radius,
                        radius, 0.0f, -M_PI / 2, 1);
    }
    else {
        CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y);
        CGContextAddLineToPoint(context, rect.origin.x + rect.size.width - radius, rect.origin.y);
    }
    
    CGContextAddLineToPoint(context, rect.origin.x + radius, rect.origin.y);
    
    //画左下角弧线
    if (cornerMask & UIImageRoundedCornerBottomLeft) {
        CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + radius, radius,
                        -M_PI / 2, M_PI, 1);
    }
    else {
        CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y);
        CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + radius);
    }
    
    CGContextClosePath(context);
}

- (UIImage *)imageWithRoundedRectWithRadius:(float)radius cornerMask:(UIImageRoundedCorner)cornerMask
{
    //    int w = self.size.width;
    //    int h = self.size.height;
    
    //zhouhong 乘以scale，解决高清屏时生成的圆角图片模糊问题（iOS4.x特别明显）
    int w = self.size.width * self.scale;
    int h = self.size.height * self.scale;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context,CGRectMake(0, 0, w, h), radius, cornerMask);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), self.CGImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIImage    *newImage = [UIImage imageWithCGImage:imageMasked];
    CGImageRelease(imageMasked);
    
    return newImage;
}

- (UIImage *)imageWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle {
    int w = self.size.width * self.scale;
    int h = self.size.height * self.scale;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    CGPoint center = CGPointMake(w / 2, h / 2);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, center.x, center.y);
    CGContextAddArc(context, center.x, center.y, w / 2, startAngle, endAngle, 0);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), self.CGImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIImage    *newImage = [UIImage imageWithCGImage:imageMasked];
    CGImageRelease(imageMasked);
    
    return newImage;
}

- (UIImage *)scaletoScale:(float)scaleSize {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.size.width*scaleSize, self.size.height*scaleSize), NO, kScreenScale);
    [self drawInRect:CGRectMake(0, 0, self.size.width*scaleSize, self.size.height*scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)scaletoSize:(float)imageSize {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageSize, imageSize), NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, imageSize, imageSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)scaletoWidth:(float)destWmageWidth {
    if (self.size.width < destWmageWidth) {
        return self;
    }
    CGFloat imageHeight = self.size.height * 1.0 /self.size.width * destWmageWidth;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(destWmageWidth, imageHeight), NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, destWmageWidth, imageHeight)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)scaletoSizeRect:(CGSize)imageSize {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageSize.width, imageSize.height), NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)imageWithRect:(CGRect)rect {
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, CGRectMake(rect.origin.x*self.scale,
                                                                                   rect.origin.y*self.scale,
                                                                                   rect.size.width*self.scale,
                                                                                   rect.size.height*self.scale));
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    return smallImage;
}

- (UIImage *)addImage:(UIImage *)image {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, self.size.width*self.scale, self.size.height*self.scale)];
    [image drawInRect:CGRectMake(0, 0, image.size.width*image.scale, image.size.height*image.scale)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

- (UIImage *)addImage:(UIImage *)image frame:(CGRect)frame {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, self.size.width*self.scale, self.size.height*self.scale)];
    [image drawInRect:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width*self.scale, frame.size.height*self.scale)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, self.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 缩放图片到指定的尺寸
 
 - parameter newSize: 需要缩放的尺寸
 
 - returns: 返回缩放后的图片
 */
- (UIImage *)resizeImageWithNewSize:(CGSize)newSize {
    
    return [self resizeImageWithNewSize:newSize percent:1 fillColor:nil];
}

/**
 缩放图片到指定的尺寸
 
 - parameter newSize: 需要缩放的尺寸
 
 - returns: 返回缩放后的图片
 */
- (UIImage *)resizeImageWithNewSize:(CGSize)newSize percent:(float)percent fillColor:(UIColor *)fillColor {
    
    if (nil == fillColor) {
        fillColor = colorWithRGB(e6e6e6);
    }
    
    int width = newSize.width;
    int height = newSize.height;
    
    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));
    
    // clear the pixels so any transparency is preserved
    memset(pixels, 0, width * height * sizeof(uint32_t));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    
    if (context) {
        
        CGRect rect = CGRectZero;
        CGSize oldSize = self.size;
        
        if (newSize.width / newSize.height > oldSize.width / oldSize.height) {
            rect.size.width = (newSize.height * oldSize.width / oldSize.height) * percent;
            rect.size.height = newSize.height * percent;
        } else {
            rect.size.width = newSize.width * percent;
            rect.size.height = (newSize.width * oldSize.height / oldSize.width) * percent;
        }
        
        rect.origin.x = (newSize.width - rect.size.width) * 0.5;
        rect.origin.y = (newSize.height - rect.size.height) * 0.5;
        
        CGContextSetFillColorWithColor(context, fillColor.CGColor);
        CGContextFillRect(context, CGRectMake(0, 0, newSize.width, newSize.height));
    
        // paint the bitmap to our context which will fill in the pixels array
        CGContextDrawImage(context, rect, [self CGImage]);
        
        CGImageRef imageMasked = CGBitmapContextCreateImage(context);
        CGContextRelease(context);
        CGColorSpaceRelease(colorSpace);
        
        UIImage *resizeImage = [UIImage imageWithCGImage:imageMasked];
        CGImageRelease(imageMasked);
        free(pixels);
        return resizeImage;
    }
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    return self;
    
}

@end
