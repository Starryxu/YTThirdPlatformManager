//
//  UIImage+PTUtil.m
//  Pods
//
//  Created by aron on 2017/11/16.
//
//

#import "UIImage+PTUtil.h"

@implementation UIImage (PTUtil)

- (UIImage *)scaletoScale:(float)scaleSize {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.size.width*scaleSize, self.size.height*scaleSize), NO, [UIScreen mainScreen].bounds.size.width);
    [self drawInRect:CGRectMake(0, 0, self.size.width*scaleSize, self.size.height*scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
