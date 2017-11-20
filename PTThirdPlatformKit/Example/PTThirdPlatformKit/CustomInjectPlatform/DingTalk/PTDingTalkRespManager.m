//
//  PTDingTalkRespManager.m
//  PTThirdPlatformKit
//
//  Created by aron on 2017/11/20.
//  Copyright © 2017年 flypigrmvb. All rights reserved.
//

#import "PTDingTalkRespManager.h"

@implementation PTDingTalkRespManager

DEF_SINGLETON

/**
 第三方APP使用 +[DTOpenAPI sendReq:] 向钉钉发送消息后, 钉钉会处理完请求后会回调该接口.
 
 @param resp 来自钉钉具体的响应.
 */
- (void)onResp:(DTBaseResp *)resp {
    if (DTOpenAPISuccess == resp.errorCode) {
        [self.delegate respManagerDidRecvMessageResponse:YES platform:PTCustumShareTypeDingTalk];
    } else {
        [self.delegate respManagerDidRecvMessageResponse:NO platform:PTCustumShareTypeDingTalk];
    }
}

@end
