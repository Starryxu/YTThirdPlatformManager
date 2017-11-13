//
//  PTAbsThirdPlatformRequestHandler.h
//  Plush
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 qingot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTThirdPlatformDefine.h"

@class OrderModel, ThirdPlatformShareModel;

@protocol PTAbsThirdPlatformRequestHandler <NSObject>

@optional

// 第三方授权
+ (BOOL)sendAuthInViewController:(UIViewController *)viewController;

// 支付
+ (BOOL)payWithOrder:(OrderModel*)order;

// 分享
+ (BOOL)sendMessageWithModel:(ThirdPlatformShareModel*)model;

@end
