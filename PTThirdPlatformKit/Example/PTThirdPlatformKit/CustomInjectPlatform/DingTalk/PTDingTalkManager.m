//
//  PTDingTalkManager.m
//  PTThirdPlatformKit
//
//  Created by aron on 2017/11/20.
//  Copyright © 2017年 flypigrmvb. All rights reserved.
//

#import "PTDingTalkManager.h"
#import <DTShareKit/DTOpenKit.h>
#import "PTThirdPlatformKit.h"
#import "PTDingTalkRespManager.h"
#import "PTDingTalkRequestHandler.h"

@implementation PTDingTalkManager

DEF_SINGLETON

- (void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 子类实现
    // 初始化钉钉模块
    NSString* appID = [[PTThirdPlatformManager sharedInstance] appIDWithPlaform:PTCustumShareTypeDingTalk];
    [DTOpenAPI registerApp:appID];
}

/**
 第三方平台处理URL
 */
- (BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application
                                   openURL:(NSURL *)url
                         sourceApplication:(NSString *)sourceApplication
                                annotation:(id)annotation {
    // 钉钉URL处理
    if ([DTOpenAPI handleOpenURL:url delegate:[PTDingTalkRespManager sharedInstance]]) {
        return YES;
    }
    
    return NO;
}

// 分享
- (void)doShareWithModel:(ThirdPlatformShareModel *)model {
    self.shareResultBlock = model.shareResultBlock;
    [PTDingTalkRespManager sharedInstance].delegate = self;
    BOOL shareResult = [PTDingTalkRequestHandler sendMessageWithModel:model];
    if (shareResult == NO) {
        !self.shareResultBlock ?: self.shareResultBlock(PTShareTypeQQ, PTShareResultFailed, nil);
    }
}

- (BOOL)isThirdPlatformInstalled:(PTShareType)thirdPlatform {
    return [DTOpenAPI isDingTalkInstalled];
}

@end
