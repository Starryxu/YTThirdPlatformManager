//
//  PTAlipayRequestHandler.m
//  Plush
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 qingot. All rights reserved.
//

#import "PTAlipayRequestHandler.h"
#import "PTAlipayRespManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "PTThirdPlatformObject.h"

@implementation PTAlipayRequestHandler

// 支付
+ (BOOL)payWithOrder:(OrderModel*)order {
    // 开始支付
    NSString* orderString = order.sign;
    NSString* appScheme = @"alipayPlush";
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        [[PTAlipayRespManager sharedInstance] setResponse:resultDic];
    }];
    return YES;
}

@end
