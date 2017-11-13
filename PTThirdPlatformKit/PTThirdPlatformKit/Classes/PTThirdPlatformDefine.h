//
//  PTThirdPlatformDefine.h
//  Plush
//
//  Created by aron on 2017/10/23.
//  Copyright © 2017年 qingot. All rights reserved.
//

#ifndef PTThirdPlatformDefine_h
#define PTThirdPlatformDefine_h


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
