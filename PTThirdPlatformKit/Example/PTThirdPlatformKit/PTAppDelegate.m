//
//  PTAppDelegate.m
//  PTThirdPlatformKit
//
//  Created by flypigrmvb on 11/13/2017.
//  Copyright (c) 2017 flypigrmvb. All rights reserved.
//

#import "PTAppDelegate.h"
#import <PTThirdPlatformKit/PTThirdPlatformKit.h>
#import "PTDingTalkManager.h"

@implementation PTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 自定义的第三方平台以插件的方式添加
    PTThirdPlatformManager* configInstance = [PTThirdPlatformManager sharedInstance];
    [configInstance addCustomSharePlatform:PTCustumShareTypeDingTalk
                              managerClass:PTDingTalkManager.class];
    [configInstance setPlaform:PTCustumShareTypeDingTalk
                         appID:kDingTalkAppID
                        appKey:nil
                     appSecret:nil
                   redirectURL:nil
                    URLSchemes:nil];
    
    
    // 第三方平台注册
    [configInstance setPlaform:PTThirdPlatformTypeWechat
                         appID:kWXAppID
                        appKey:nil
                     appSecret:kWXAppSecret
                   redirectURL:nil
                    URLSchemes:nil];
    [configInstance setPlaform:PTThirdPlatformTypeTencentQQ
                         appID:kTencentAppID
                        appKey:kTencentAppKey
                     appSecret:kTencentAppSecret
                   redirectURL:nil
                    URLSchemes:nil];
    [configInstance setPlaform:PTThirdPlatformTypeWeibo
                         appID:kWeiboAppID
                        appKey:kWeiboAppKey
                     appSecret:kWeiboAppSecret
                   redirectURL:kWeiboRedirectURI
                    URLSchemes:nil];
    [configInstance setPlaform:PTThirdPlatformTypeAlipay
                         appID:nil
                        appKey:nil
                     appSecret:nil
                   redirectURL:nil
                    URLSchemes:kAlipayURLScheme];
    [configInstance thirdPlatConfigWithApplication:application
                     didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[PTThirdPlatformManager sharedInstance] thirdPlatCanOpenUrlWithApplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

@end
