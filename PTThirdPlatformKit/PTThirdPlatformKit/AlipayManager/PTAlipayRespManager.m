//
//  PTAlipayRespManager.m
//  Plush
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 qingot. All rights reserved.
//

#import "PTAlipayRespManager.h"

@implementation PTAlipayRespManager

DEF_SINGLETON

- (void)setResponse:(NSDictionary *)response {
    // 解析 resultStatus
    NSString* resultStatusStr = [response objectForKey:@"resultStatus"];
    NSInteger resultStatus = 0;
    if ([resultStatusStr respondsToSelector:@selector(integerValue)]) {
        resultStatus = [resultStatusStr integerValue];
    }
    PTPayResult payResult = (resultStatus == 9000) ? PTPayResultSuccess : (resultStatus == 6001) ? PTPayResultCancel : PTPayResultFailed ;
    if ([self.delegate respondsToSelector:@selector(respManagerDidRecvPayResponse:platform:)]) {
        [self.delegate respManagerDidRecvPayResponse:payResult platform:PTThirdPlatformTypeAlipay];
    }
}

@end
