//
//  PTConstants.h
//  Plush
//
//  Created by yuan he on 2017/9/18.
//  Copyright © 2017年 qingot. All rights reserved.
//

#ifndef PTConstants_h
#define PTConstants_h

static NSString *kAuthScope = @" ";
static NSString *kAuthOpenID = @" ";
static NSString *kAuthState = @" ";
static NSString *kWXAppID = @" ";
static NSString *kWXAppSecret = @" ";
static NSString *kTencentAppID = @" ";
static NSString *kTencentAppKey = @" ";
static NSString *kTencentAppSecret = @"";
static NSString *kWeiboAppID = @" ";
static NSString *kWeiboAppKey = @" ";
static NSString *kWeiboAppSecret = @" ";
static NSString *kWeiboRedirectURI = @"https://api.weibo.com/oauth2/default.html";
static NSString *kDingTalkAppID = @"dingoak5hqhuvmpfhpnjvt";

// !!! @important 自定义第三平台的类型需要大于等于999，以避免和内置的第三方平台的类型冲突
typedef enum : NSUInteger {
    PTCustumShareTypeDingTalk = 999,
} PTCustumShareType;

#endif /* PTConstants_h */
