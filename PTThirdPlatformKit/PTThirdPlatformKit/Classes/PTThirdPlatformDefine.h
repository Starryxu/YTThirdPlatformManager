//
//  PTThirdPlatformDefine.h
//  Plush
//
//  Created by aron on 2017/10/23.
//  Copyright © 2017年 qingot. All rights reserved.
//

#ifndef PTThirdPlatformDefine_h
#define PTThirdPlatformDefine_h

// 单例工具宏
#undef    AS_SINGLETON
#define AS_SINGLETON \
+ (instancetype)sharedInstance;

#undef    DEF_SINGLETON
#define DEF_SINGLETON \
+ (instancetype)sharedInstance{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
} \

// 字符串工具宏
#define ValueOrEmpty(value)     ((value)?(value):@"")

// 线程处理相关
static inline void PTThirdPlatformOnMainThreadAsync(void (^block)(void)) {
    if ([NSThread isMainThread]) block();
    else dispatch_async(dispatch_get_main_queue(), block);
}

// 第三方平台类型
typedef NS_ENUM(NSInteger, PTThirdPlatformType) {
    PTThirdPlatformTypeWechat = 100,//微信
    PTThirdPlatformTypeTencentQQ,//QQ
    PTThirdPlatformTypeWeibo,//微博
    PTThirdPlatformTypeAlipay,//支付宝
};

// 第三方平台类型对应的子类型
typedef NS_ENUM(NSInteger, PTThirdPlatformSubType) {
    PTThirdPlatformSubTypeTotal = 1,//所有的子类型，不区分
    PTThirdPlatformSubTypeAuthShare,//分享授权子类型
    PTThirdPlatformSubTypePay,//支付子类型
};

// 分享类型
typedef NS_ENUM(NSInteger, PTShareType) {
    PTShareTypeUnknow = 200,
    PTShareTypeWechat,
    PTShareTypeWechatLine,
    PTShareTypeQQ,
    PTShareTypeQQZone,
    PTShareTypeWeibo,
};

// 分享内容类型
typedef NS_ENUM(NSInteger, PTShareContentType) {
    PTShareContentTypeWebPage,
    PTShareContentTypeVideo,
};

// 分享结果
typedef NS_ENUM(NSInteger, PTShareResult) {
    PTShareResultSuccess,
    PTShareResultFailed,
    PTShareResultCancel,
};

// 支付结果结果
typedef NS_ENUM(NSInteger, PTPayResult) {
    PTPayResultSuccess,
    PTPayResultFailed,
    PTPayResultCancel,
};

#endif /* PTThirdPlatformDefine_h */
