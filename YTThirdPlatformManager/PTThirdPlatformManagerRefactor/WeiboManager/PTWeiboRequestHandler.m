//
//  PTWeiboRequestHandler.m
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 aron. All rights reserved.
//

#import "PTWeiboRequestHandler.h"
#import <WeiboSDK/WeiboSDK.h>
#import "PTThirdPlatformConfigConst.h"

@implementation PTWeiboRequestHandler

// 第三方授权
+ (BOOL)sendAuthInViewController:(UIViewController *)viewController {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kWeiboRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    return [WeiboSDK sendRequest:request];
}

// 分享
+ (BOOL)sendMessageWithImage:(UIImage*)image
              imageUrlString:(NSString*)imageUrlString
                   urlString:(NSString*)urlString
                       title:(NSString*)title
                        text:(NSString*)text
                   shareType:(PTShareType)shareType {
    WBMessageObject* msg = [WBMessageObject message];
    WBWebpageObject* mediaObj = [WBWebpageObject object];
    mediaObj.objectID = [NSString stringWithFormat:@"%@", @(arc4random_uniform(100000))];
    mediaObj.title = title;
    mediaObj.description = text;
    mediaObj.webpageUrl = urlString;
    NSData* thumbData = UIImageJPEGRepresentation([self scaledImageWithOriImage:image], 1.0);
    mediaObj.thumbnailData = thumbData;
    msg.mediaObject = mediaObj;
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:msg];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    return [WeiboSDK sendRequest:request];
}

+ (UIImage*)scaledImageWithOriImage:(UIImage*)oriImage {
    NSInteger maxSharedImageBytes = 32*1000;//32K
    NSInteger oriImageBytes = UIImageJPEGRepresentation(oriImage, 1.0).length;
    if (oriImageBytes > maxSharedImageBytes) {
        CGFloat scaleFactor = maxSharedImageBytes * 1.0f / oriImageBytes * 1.0f;
        UIImage* scaledImage = [self scaletoScale:scaleFactor originalImage:oriImage];
        if (scaledImage) {
            return scaledImage;
        }
    }
    return oriImage;
}

+ (UIImage *)scaletoScale:(float)scaleSize originalImage:(UIImage*)originalImage {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(originalImage.size.width*scaleSize, originalImage.size.height*scaleSize), NO, [UIScreen mainScreen].scale);
    [originalImage drawInRect:CGRectMake(0, 0, originalImage.size.width*scaleSize, originalImage.size.height*scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
