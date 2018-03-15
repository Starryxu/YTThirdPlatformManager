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
static NSString *kTencentAppID = @"1106408873";
static NSString *kTencentAppKey = @"RjJS4GvZTs7bwXiO";
static NSString *kTencentAppSecret = @"";
static NSString *kQQPayAppID = @"1106473305";
static NSString *kQQPayAppKey = @" ";
static NSString *kQQPayURLScheme = @"qqpay_plush";
static NSString *kWeiboAppID = @"1286712227";
static NSString *kWeiboAppKey = @"1982064134";
static NSString *kWeiboAppSecret = @"c5abe691559201e91ce975ee26111e44";
static NSString *kWeiboRedirectURI = @"https://api.weibo.com/oauth2/default.html";
static NSString *kDingTalkAppID = @"dingoak5hqhuvmpfhpnjvt";
static NSString *kAlipayURLScheme = @"alipayPlush";

// !!! @important 自定义第三平台的类型需要大于等于999，以避免和内置的第三方平台的类型冲突
typedef enum : NSUInteger {
    PTCustumShareTypeDingTalk = 999,
} PTCustumShareType;

#endif /* PTConstants_h */
