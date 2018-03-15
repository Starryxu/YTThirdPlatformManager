//
//  PTAbsThirdPlatformManager.h
//  Plush
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 qingot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTThirdPlatformDefine.h"

@class OrderModel, ThirdPlatformUserInfo, ThirdPlatformShareModel;

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
 */
- (void)shareWithModel:(ThirdPlatformShareModel*)model;

/**
 第三方支付

 @param payMethodType 支付平台
 @param order 支付订单模型
 @param paymentBlock 支付结果回调
 */
- (void)payWithPlateform:(PTThirdPlatformType)payMethodType order:(OrderModel*)order paymentBlock:(void (^)(PTPayResult result))paymentBlock;

// APP是否安装
- (BOOL)isThirdPlatformInstalled:(PTShareType)thirdPlatform;

@end
