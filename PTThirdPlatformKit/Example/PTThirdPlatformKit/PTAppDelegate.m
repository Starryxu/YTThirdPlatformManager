//
//  PTAppDelegate.m
//  PTThirdPlatformKit
//
//  Created by flypigrmvb on 11/13/2017.
//  Copyright (c) 2017 flypigrmvb. All rights reserved.
//

#import "PTAppDelegate.h"
#import <PTThirdPlatformKit/PTThirdPlatformConfigManager.h>

#define DeveloperMode   PT_DEVELOPER

#if DeveloperMode
#import "PTConstants_Developer.h"
#else
#import "PTConstants.h"
#endif


@implementation PTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 第三方平台注册
    [[PTThirdPlatformConfigManager sharedInstance] setPlaform:PTThirdPlatformTypeWechat appID:kWXAppID appKey:nil appSecret:kWXAppSecret redirectURL:nil];
    [[PTThirdPlatformConfigManager sharedInstance] setPlaform:PTThirdPlatformTypeTencentQQ appID:kTencentAppID appKey:kTencentAppKey appSecret:kTencentAppSecret redirectURL:nil];
    [[PTThirdPlatformConfigManager sharedInstance] setPlaform:PTThirdPlatformTypeWeibo appID:kWeiboAppID appKey:kWeiboAppKey appSecret:kWeiboAppSecret redirectURL:kWeiboRedirectURI];
    [[PTThirdPlatformConfigManager sharedInstance] setPlaform:PTThirdPlatformTypeAlipay appID:nil appKey:nil appSecret:nil redirectURL:nil];
    [[PTThirdPlatformConfigManager sharedInstance] thirdPlatConfigWithApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[PTThirdPlatformConfigManager sharedInstance] thirdPlatCanOpenUrlWithApplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

@end
