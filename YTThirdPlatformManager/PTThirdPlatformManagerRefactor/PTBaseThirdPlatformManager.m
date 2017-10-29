//
//  PTBaseThirdPlatformManager.m
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 aron. All rights reserved.
//

#import "PTBaseThirdPlatformManager.h"
#import <SDWebImage/SDWebImageManager.h>


@implementation PTBaseThirdPlatformManager

- (void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 子类实现
    NSAssert(YES, @"哥么，这里你忘记实现了");
}

/**
 第三方平台处理URL
 */
- (BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application
                                   openURL:(NSURL *)url
                         sourceApplication:(NSString *)sourceApplication
                                annotation:(id)annotation {
    // 子类实现
    NSAssert(YES, @"哥么，这里你忘记实现了");
    return NO;
}

/**
 第三方分享
 
 @param platform 第三方分享平台
 @param image 分享的图片
 @param imageUrlString 分享的图片地址
 @param title 分享的标题
 @param text 分享的文字
 @param urlString 分享的URL
 @param fromViewController 从哪个页面调用的分享
 @param shareResultBlock 分享结果回调
 */
- (void)shareToPlateform:(PTShareType)platform
                   image:(UIImage*)image
          imageUrlString:(NSString*)imageUrlString
                   title:(NSString*)title
                    text:(NSString*)text
               urlString:(NSString*)urlString
      fromViewController:(UIViewController*)fromViewController
        shareResultBlock:(void (^) (PTShareType platform, PTShareResult shareResult, NSError* error))shareResultBlock {
    __block UIImage* sharedImage = nil;
    if (image) {
        sharedImage = image;
        [self doShareToPlateform:platform image:sharedImage imageUrlString:imageUrlString title:title text:text urlString:urlString fromViewController:fromViewController shareResultBlock:shareResultBlock];
    } else if (imageUrlString != nil) {
        [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:imageUrlString] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            if (image) {
                sharedImage = image;
            } else {
                sharedImage = [UIImage imageNamed:@"app_icon"];
            }
            [self doShareToPlateform:platform image:sharedImage imageUrlString:imageUrlString title:title text:text urlString:urlString fromViewController:fromViewController shareResultBlock:shareResultBlock];
        }];
    } else {
        sharedImage = [UIImage imageNamed:@"signin_logo"];
        [self doShareToPlateform:platform image:sharedImage imageUrlString:imageUrlString title:title text:text urlString:urlString fromViewController:fromViewController shareResultBlock:shareResultBlock];
    }
}

- (void)doShareToPlateform:(PTShareType)platform
                     image:(UIImage*)image
            imageUrlString:(NSString*)imageUrlString
                     title:(NSString*)title
                      text:(NSString*)text
                 urlString:(NSString*)urlString
        fromViewController:(UIViewController*)fromViewController
          shareResultBlock:(void (^) (PTShareType platform, PTShareResult shareResult, NSError* error))shareResultBlock {
    // 空实现，子类实现该方法
}

/**
 第三方登录
 
 @param thirdPlatformType 第三方平台
 @param viewController 从哪个页面调用的分享
 @param callback 登录回调
 */
- (void)signInWithType:(PTThirdPlatformType)thirdPlatformType fromViewController:(UIViewController *)viewController callback:(void (^)(ThirdPlatformUserInfo* userInfo, NSError* err))callback {
    // 空实现，子类实现该方法
}

/**
 第三方支付
 
 @param payMethodType 支付平台
 @param order 支付订单模型
 @param paymentBlock 支付结果回调
 */
- (void)payWithPlateform:(PTPaymentMethodType)payMethodType order:(PTOrderModel*)order paymentBlock:(void (^)(BOOL result))paymentBlock {
    // 空实现，子类实现该方法
}

#pragma mark - ......::::::: PTAbsThirdPlatformRespManagerDelegate :::::::......

- (void)respManagerDidRecvAuthResponse:(ThirdPlatformUserInfo *)response platform:(PTThirdPlatformType)platform {
    PTOnMainThreadAsync(^{
        !_callback ?: _callback(response, nil);
    });
}

- (void)respManagerDidRecvMessageResponse:(BOOL)result platform:(PTShareType)platform {
    PTOnMainThreadAsync(^{
        if (result) {
            !self.shareResultBlock ?: self.shareResultBlock(platform, PTShareResultSuccess, nil);
        } else {
            !self.shareResultBlock ?: self.shareResultBlock(platform, PTShareResultFailed, nil);
        }
    });
}

- (void)respManagerDidRecvPayResponse:(BOOL)result platform:(PTPaymentMethodType)platform {
    PTOnMainThreadAsync(^{
        !self.paymentBlock ?: self.paymentBlock(result);
    });
}

@end
