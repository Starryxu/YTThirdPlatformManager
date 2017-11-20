//
//  PTWeiboRequestHandler.m
//  Plush
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 qingot. All rights reserved.
//

#import "PTWeiboRequestHandler.h"
#import <WeiboSDK/WeiboSDK.h>
#import "PTThirdPlatformManager.h"
#import "PTThirdPlatformObject.h"
#import "UIImage+PTUtil.h"

@implementation PTWeiboRequestHandler

// 第三方授权
+ (BOOL)sendAuthInViewController:(UIViewController *)viewController {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    NSString* redirectURL = [[PTThirdPlatformManager sharedInstance] appIDWithPlaform:PTThirdPlatformTypeWeibo];
    request.redirectURI = redirectURL;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    return [WeiboSDK sendRequest:request];
}

// 分享
+ (BOOL)sendMessageWithModel:(ThirdPlatformShareModel *)model {
    WBMessageObject* msg = [WBMessageObject message];
    
    if (PTShareContentTypeVideo == model.mediaObject.contentType) {
        msg.text = [NSString stringWithFormat:@"%@ %@", model.weiboText, model.urlString];
        
        WBImageObject* imageObj = [WBImageObject object];
        NSInteger maxSharedImageBytes = 10*1000*1000; // 10M
        NSData* imageData = UIImageJPEGRepresentation([self scaledImageWithOriImage:model.image maxBytes:maxSharedImageBytes], 1.0);
        imageObj.imageData = imageData;
        msg.imageObject = imageObj;

//        msg.text = model.weiboText;
//        PTSharedVideoObject* mediaObj = (PTSharedVideoObject*)model.mediaObject;
//        WBVideoObject* videoObj = [WBVideoObject object];
//        videoObj.objectID = mediaObj.videoUrl;
//        videoObj.videoUrl = model.urlString;
//        videoObj.title = model.weiboText;
//        msg.mediaObject = videoObj;
        
    } else {
        msg.text = [NSString stringWithFormat:@"%@ %@", model.weiboText, model.urlString];

        WBImageObject* imageObj = [WBImageObject object];
        NSInteger maxSharedImageBytes = 10*1000*1000; // 10M
        NSData* imageData = UIImageJPEGRepresentation([self scaledImageWithOriImage:model.image maxBytes:maxSharedImageBytes], 1.0);
        imageObj.imageData = imageData;
        msg.imageObject = imageObj;
    }
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:msg];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    return [WeiboSDK sendRequest:request];
}

+ (UIImage*)scaledImageWithOriImage:(UIImage*)oriImage maxBytes:(NSInteger)maxBytes {
    NSInteger oriImageBytes = UIImageJPEGRepresentation(oriImage, 1.0).length;
    if (oriImageBytes > maxBytes) {
        CGFloat scaleFactor = maxBytes * 1.0f / oriImageBytes * 1.0f;
        UIImage* scaledImage = [oriImage scaletoScale:scaleFactor];
        if (scaledImage) {
            return scaledImage;
        }
    }
    return oriImage;
}

@end
