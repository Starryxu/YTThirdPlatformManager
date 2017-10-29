//
//  PTWXManager.m
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 aron. All rights reserved.
//

#import "PTWXManager.h"
#import "PTWXRespManager.h"
#import "PTWXRequestHandler.h"
#import <WXApi.h>
#import "PTThirdPlatformConfigConst.h"

@interface PTWXManager () <PTAbsThirdPlatformRespManagerDelegate>
@end


@implementation PTWXManager

DEF_SINGLETON

- (void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 子类实现
    //向微信注册
    [WXApi registerApp:kWXAppID];
}

/**
 第三方平台处理URL
 */
- (BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application
                                   openURL:(NSURL *)url
                         sourceApplication:(NSString *)sourceApplication
                                annotation:(id)annotation {
    // 微信
    if ([WXApi handleOpenURL:url delegate:[PTWXRespManager sharedInstance]]) {
        return YES;
    }
    return NO;
}

/**
 第三方登录
 
 @param thirdPlatformType 第三方平台
 @param fromViewController 从哪个页面调用的分享
 @param callback 登录回调
 */
- (void)signInWithType:(PTThirdPlatformType)thirdPlatformType fromViewController:(UIViewController *)viewController callback:(void (^)(ThirdPlatformUserInfo* userInfo, NSError* err))callback {
    self.callback = callback;
    [PTWXRespManager sharedInstance].delegate = self;
    [PTWXRequestHandler sendAuthInViewController:viewController];
}

/**
 第三方分享，子类重写这个方法，由父类的shareToPlateform方法调用子类的该方法
 
 @param platform 第三方分享平台
 @param image 分享的图片
 @param imageUrlString 分享的图片地址
 @param title 分享的标题
 @param text 分享的文字
 @param urlString 分享的URL
 @param fromViewController 从哪个页面调用的分享
 @param shareResultBlock 分享结果回调
 */
- (void)doShareToPlateform:(PTShareType)platform
                     image:(UIImage*)image
            imageUrlString:(NSString*)imageUrlString
                     title:(NSString*)title
                      text:(NSString*)text
                 urlString:(NSString*)urlString
        fromViewController:(UIViewController*)fromViewController
          shareResultBlock:(void (^) (PTShareType platform, PTShareResult shareResult, NSError* error))shareResultBlock {
    self.shareResultBlock = shareResultBlock;
    [self doWechatShareWithImage:image urlString:urlString title:title text:text platform:platform fromViewController:fromViewController];
}

- (void)doWechatShareWithImage:(UIImage*)image
                     urlString:(NSString*)urlString
                         title:(NSString*)title
                          text:(NSString*)text
                      platform:(PTShareType)platform
            fromViewController:(UIViewController*)fromViewController {
    [PTWXRespManager sharedInstance].delegate = self;
    BOOL shareResult = [PTWXRequestHandler sendMessageWithImage:image imageUrlString:nil urlString:urlString title:title text:text shareType:platform];
    if (shareResult == NO) {
        !self.shareResultBlock ?: self.shareResultBlock(PTShareTypeWechat, PTShareResultFailed, nil);
    }
}

/**
 第三方支付
 
 @param payMethodType 支付平台
 @param order 支付订单模型
 @param paymentBlock 支付结果回调
 */
- (void)payWithPlateform:(PTPaymentMethodType)payMethodType order:(PTOrderModel*)order paymentBlock:(void (^)(BOOL result))paymentBlock {
    self.paymentBlock = paymentBlock;
    // 使用支付宝支付
    [PTWXRespManager sharedInstance].delegate = self;
    [PTWXRequestHandler payWithOrder:order];
}

@end
