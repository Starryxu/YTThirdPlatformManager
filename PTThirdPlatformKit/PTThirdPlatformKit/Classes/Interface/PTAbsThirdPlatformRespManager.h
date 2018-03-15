//
//  PTAbsThirdPlatformRespManager.h
//  Plush
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 qingot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTThirdPlatformDefine.h"

@class ThirdPlatformUserInfo;

// RespManagerDelegate
@protocol PTAbsThirdPlatformRespManagerDelegate <NSObject>

@optional

- (void)respManagerDidRecvPayResponse:(PTPayResult)result platform:(PTThirdPlatformType)platform;
- (void)respManagerDidRecvAuthResponse:(ThirdPlatformUserInfo *)response platform:(PTThirdPlatformType)platform;
- (void)respManagerDidRecvMessageResponse:(BOOL)result platform:(PTShareType)platform;

@end


@protocol PTAbsThirdPlatformRespManager <NSObject>

@optional

// 代理，子类需要设置getter/setter
@property (nonatomic, weak) id<PTAbsThirdPlatformRespManagerDelegate> delegate;

@end

