//
//  PTAbsThirdPlatformManager.h
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 aron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PTThirdPlatformDefine.h"
#import "PTThirdPlatformObject.h"
#import "UtilMacro.h"

@class PTOrderModel;

@protocol PTAbsThirdPlatformManager <NSObject>

@optional

- (void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

/**
 第三方平台处理URL
 */
- (BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application
                                   openURL:(NSURL *)url
                         sourceApplication:(NSString *)sourceApplication
                                annotation:(id)annotation;

/**
 第三方登录
 
 @param thirdPlatformType 第三方平台
 @param viewController 从哪个页面调用的分享
 @param callback 登录回调
 */
- (void)signInWithType:(PTThirdPlatformType)thirdPlatformType
    fromViewController:(UIViewController *)viewController
              callback:(void (^)(ThirdPlatformUserInfo* userInfo, NSError* err))callback;

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
        shareResultBlock:(void (^) (PTShareType platform, PTShareResult shareResult, NSError* error))shareResultBlock;

/**
 第三方支付

 @param payMethodType 支付平台
 @param order 支付订单模型
 @param paymentBlock 支付结果回调
 */
- (void)payWithPlateform:(PTPaymentMethodType)payMethodType 
                order:(PTOrderModel*)order
                 paymentBlock:(void (^)(BOOL result))paymentBlock;

@end
