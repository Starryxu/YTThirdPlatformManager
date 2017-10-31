//
//  PTWeiboManager.m
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 aron. All rights reserved.
//

#import "PTWeiboManager.h"
#import "PTWeiboRespManager.h"
#import "PTWeiboRequestHandler.h"
#import "PTThirdPlatformConfigConst.h"


@interface PTWeiboManager () <PTAbsThirdPlatformRespManagerDelegate>
@end

@implementation PTWeiboManager

DEF_SINGLETON

- (void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 子类实现
    // 初始化微博模块
#if DEBUG
    [WeiboSDK enableDebugMode:YES];
#endif
    [WeiboSDK registerApp:kWeiboAppKey];
}

/**
 第三方平台处理URL
 */
- (BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application
                                   openURL:(NSURL *)url
                         sourceApplication:(NSString *)sourceApplication
                                annotation:(id)annotation {
    // Weibo
    if ([WeiboSDK handleOpenURL:url delegate:[PTWeiboRespManager sharedInstance]]) {
        return YES;
    }
    
    return NO;
}

/**
 第三方登录
 
 @param thirdPlatformType 第三方平台
 @param viewController 从哪个页面调用的分享
 @param callback 登录回调
 */
- (void)signInWithType:(PTThirdPlatformType)thirdPlatformType fromViewController:(UIViewController *)viewController callback:(void (^)(ThirdPlatformUserInfo* userInfo, NSError* err))callback {
    self.callback = callback;
    [PTWeiboRespManager sharedInstance].delegate = self;
    [PTWeiboRequestHandler sendAuthInViewController:viewController];
}

- (void)doShareToPlateform:(PTShareType)platform
                     image:(UIImage *)image
            imageUrlString:(NSString *)imageUrlString
                     title:(NSString *)title
                      text:(NSString *)text
                 urlString:(NSString *)urlString
        fromViewController:(UIViewController *)fromViewController
          shareResultBlock:(void (^)(PTShareType, PTShareResult, NSError *))shareResultBlock {
    self.shareResultBlock = shareResultBlock;
    [self doWeiboShareWithImage:image
                 imageUrlString:imageUrlString
                      urlString:urlString
                          title:title
                           text:text
                      shareType:platform
             fromViewController:fromViewController];
}

// 微博分享
- (void)doWeiboShareWithImage:(UIImage*)image
               imageUrlString:(NSString*)imageUrlString
                    urlString:(NSString*)urlString
                        title:(NSString*)title
                         text:(NSString*)text
                    shareType:(PTShareType)shareType
           fromViewController:(UIViewController*)fromViewController {
    [PTWeiboRespManager sharedInstance].delegate = self;
    BOOL shareResult = [PTWeiboRequestHandler sendMessageWithImage:image imageUrlString:imageUrlString urlString:urlString title:title text:text shareType:shareType];
    if (shareResult == NO) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // [Dialog toast:_(@"Please install Wechat")];
        });
        !self.shareResultBlock ?: self.shareResultBlock(shareType, PTShareResultFailed, nil);
    }
}


@end
