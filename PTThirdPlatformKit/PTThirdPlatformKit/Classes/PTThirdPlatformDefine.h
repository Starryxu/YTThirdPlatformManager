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
    PTThirdPlatformTypeWechat = 1,//微信
    PTThirdPlatformTypeTencentQQ,//QQ
    PTThirdPlatformTypeWeibo,//微博
    PTThirdPlatformTypeAlipay,//支付宝
};

// 分享类型
typedef NS_ENUM(NSInteger, PTShareType) {
    PTShareTypeUnknow,
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

typedef NS_ENUM(NSInteger, PTShareResult) {
    PTShareResultSuccess,
    PTShareResultFailed,
    PTShareResultCancel,
};


#endif /* PTThirdPlatformDefine_h */
