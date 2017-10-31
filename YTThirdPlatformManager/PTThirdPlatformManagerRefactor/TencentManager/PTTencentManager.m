//
//  PTTencentManager.m
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 aron. All rights reserved.
//

#import "PTTencentManager.h"
#import "PTTencentRespManager.h"
#import "PTTencentRequestHandler.h"

@interface PTTencentManager () <PTAbsThirdPlatformRespManagerDelegate>
@end


@implementation PTTencentManager

DEF_SINGLETON

- (void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 子类实现
    // 初始化QQ模块
    [PTTencentRespManager sharedInstance];
}

/**
 第三方平台处理URL
 */
- (BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application
                                   openURL:(NSURL *)url
                         sourceApplication:(NSString *)sourceApplication
                                annotation:(id)annotation {
    // QQ 授权
    if ([TencentOAuth CanHandleOpenURL:url] && [TencentOAuth HandleOpenURL:url]) {
        return YES;
    }
    
    // QQ 业务
    if ([QQApiInterface handleOpenURL:url delegate:[PTTencentRespManager sharedInstance]]) {
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
    [PTTencentRespManager sharedInstance].delegate = self;
    [PTTencentRequestHandler sendAuthInViewController:viewController];
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
    [self doQQShareWithImage:image
              imageUrlString:imageUrlString
                   urlString:urlString
                       title:title
                        text:text
                   shareType:platform
          fromViewController:fromViewController];
}

// 分享到QQ
- (void)doQQShareWithImage:(UIImage*)image
            imageUrlString:(NSString*)imageUrlString
                 urlString:(NSString*)urlString
                     title:(NSString*)title
                      text:(NSString*)text
                 shareType:(PTShareType)shareType
        fromViewController:(UIViewController*)fromViewController {
    [PTTencentRespManager sharedInstance].delegate = self;
    BOOL shareResult = [PTTencentRequestHandler sendMessageWithImage:image imageUrlString:imageUrlString urlString:urlString title:title text:text shareType:shareType];
    if (shareResult == NO) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // [Dialog toast:_(@"Please install Wechat")];
        });
        !self.shareResultBlock ?: self.shareResultBlock(PTShareTypeQQ, PTShareResultFailed, nil);
    }
}

@end
