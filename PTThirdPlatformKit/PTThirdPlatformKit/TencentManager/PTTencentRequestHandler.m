//
//  PTTencentRequestHandler.m
//  Plush
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 qingot. All rights reserved.
//

#import "PTTencentRequestHandler.h"
#import "PTTencentRespManager.h"
#import "PTThirdPlatformObject.h"
#import "QQWalletSDK.h"
#import "PTThirdPlatformManager.h"

@implementation PTTencentRequestHandler

// 第三方授权
+ (BOOL)sendAuthInViewController:(UIViewController *)viewController {
    NSArray* permissions = [NSArray arrayWithObjects:@"get_user_info",@"get_simple_userinfo", @"add_t", nil];
    BOOL result = [[PTTencentRespManager sharedInstance].tencentOAuth authorize:permissions inSafari:NO];
    return result;
}

// 分享
+ (BOOL)sendMessageWithModel:(ThirdPlatformShareModel *)model {
    QQApiObject* obj;
    if (PTShareContentTypeVideo == model.mediaObject.contentType) {
        // PTSharedVideoObject* mediaObj = (PTSharedVideoObject*)model.mediaObject;
        obj = [QQApiVideoObject objectWithURL:[NSURL URLWithString:ValueOrEmpty(model.urlString)] title:model.title description:model.text previewImageURL:[NSURL URLWithString:ValueOrEmpty(model.imageUrlString)]];
    } else {
       obj = [QQApiNewsObject
           objectWithURL:[NSURL URLWithString:ValueOrEmpty(model.urlString)]
           title:model.title
           description:model.text
           previewImageURL:[NSURL URLWithString:ValueOrEmpty(model.imageUrlString)]];
    }
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:obj];
    QQApiSendResultCode sent = 0;
    if (PTShareTypeQQ == model.platform) {
        //将内容分享到qq
        sent = [QQApiInterface sendReq:req];
    } else {
        //将内容分享到qzone
        sent = [QQApiInterface SendReqToQZone:req];
    }
    return EQQAPISENDSUCESS == sent;
}

// 支付
+ (BOOL)payWithOrder:(OrderModel*)order {
    // 发起支付
    NSString* appID = [[PTThirdPlatformManager sharedInstance] appIDWithPlaform:PTThirdPlatformTypeTencentQQ subType:PTThirdPlatformSubTypePay];
    NSString* scheme = [[PTThirdPlatformManager sharedInstance] URLSchemesWithPlaform:PTThirdPlatformTypeTencentQQ subType:PTThirdPlatformSubTypePay];
    [[QQWalletSDK sharedInstance] startPayWithAppId:appID
                                        bargainorId:order.prepayid
                                            tokenId:order.package
                                          signature:order.sign
                                              nonce:order.noncestr
                                             scheme:scheme
                                         completion:^(QQWalletErrCode errCode, NSString *errStr){
                                             // 支付完成的回调处理
                                             if (errCode == QQWalletErrCodeSuccess) {
                                                 // 对支付成功的处理
                                                 [[PTTencentRespManager sharedInstance] setPayResult:PTPayResultSuccess];
                                             } else if (errCode == QQWalletErrCodeUserCancel) {
                                                 // 对支付取消的处理
                                                 [[PTTencentRespManager sharedInstance] setPayResult:PTPayResultCancel];
                                             } else {
                                                 // 对支付失败的处理
                                                 [[PTTencentRespManager sharedInstance] setPayResult:PTPayResultFailed];
                                             }
                                         }];
    return YES;
}

@end
