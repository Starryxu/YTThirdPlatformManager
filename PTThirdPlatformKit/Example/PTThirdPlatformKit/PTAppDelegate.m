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
    [[PTThirdPlatformManager sharedInstance] addCustomSharePlatform:PTCustumShareTypeDingTalk managerClass:PTDingTalkManager.class];
    [[PTThirdPlatformManager sharedInstance] setPlaform:PTCustumShareTypeDingTalk appID:kDingTalkAppID appKey:nil appSecret:nil redirectURL:nil];
    
    // 第三方平台注册
    [[PTThirdPlatformManager sharedInstance] setPlaform:PTThirdPlatformTypeWechat appID:kWXAppID appKey:nil appSecret:kWXAppSecret redirectURL:nil];
    [[PTThirdPlatformManager sharedInstance] setPlaform:PTThirdPlatformTypeTencentQQ appID:kTencentAppID appKey:kTencentAppKey appSecret:kTencentAppSecret redirectURL:nil];
    [[PTThirdPlatformManager sharedInstance] setPlaform:PTThirdPlatformTypeWeibo appID:kWeiboAppID appKey:kWeiboAppKey appSecret:kWeiboAppSecret redirectURL:kWeiboRedirectURI];
    [[PTThirdPlatformManager sharedInstance] setPlaform:PTThirdPlatformTypeAlipay appID:nil appKey:nil appSecret:nil redirectURL:nil];
    [[PTThirdPlatformManager sharedInstance] thirdPlatConfigWithApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[PTThirdPlatformManager sharedInstance] thirdPlatCanOpenUrlWithApplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

@end
