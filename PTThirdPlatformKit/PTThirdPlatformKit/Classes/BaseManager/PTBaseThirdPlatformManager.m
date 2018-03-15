//
//  PTBaseThirdPlatformManager.m
//  Plush
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 qingot. All rights reserved.
//

#import "PTBaseThirdPlatformManager.h"
#import <SDWebImage/SDWebImageManager.h>
#import "PTThirdPlatformObject.h"

@implementation PTBaseThirdPlatformManager

- (void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 子类实现
    NSAssert(YES, @"哥么，这里你忘记实现了");
}

/**
 第三方平台处理URL
 */
- (BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application
                                   openURL:(NSURL *)url
                         sourceApplication:(NSString *)sourceApplication
                                annotation:(id)annotation {
    // 子类实现
    NSAssert(YES, @"哥么，这里你忘记实现了");
    return NO;
}

/**
 第三方分享
 */
- (void)shareWithModel:(ThirdPlatformShareModel*)model {
    __block UIImage* sharedImage = nil;
    if (model.image) {
        [self doShareWithModel:model];
    } else if (model.imageUrlString != nil) {
        [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:model.imageUrlString] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            if (image) {
                sharedImage = image;
            } else {
                sharedImage = [UIImage imageNamed:@"app_icon"];
            }
            model.image = sharedImage;
            [self doShareWithModel:model];
        }];
    } else {
        sharedImage = [UIImage imageNamed:@"app_icon"];
        model.image = sharedImage;
        [self doShareWithModel:model];
    }
}

- (void)doShareWithModel:(ThirdPlatformShareModel*)model {
    // 空实现，子类实现该方法
}

/**
 第三方登录
 
 @param thirdPlatformType 第三方平台
 @param viewController 从哪个页面调用的分享
 @param callback 登录回调
 */
- (void)signInWithType:(PTThirdPlatformType)thirdPlatformType fromViewController:(UIViewController *)viewController callback:(void (^)(ThirdPlatformUserInfo* userInfo, NSError* err))callback {
    // 空实现，子类实现该方法
}

/**
 第三方支付
 
 @param payMethodType 支付平台
 @param order 支付订单模型
 @param paymentBlock 支付结果回调
 */
- (void)payWithPlateform:(PTThirdPlatformType)payMethodType order:(OrderModel*)order paymentBlock:(void (^)(PTPayResult result))paymentBlock {
    // 空实现，子类实现该方法
}

#pragma mark - ......::::::: PTAbsThirdPlatformRespManagerDelegate :::::::......

- (void)respManagerDidRecvAuthResponse:(ThirdPlatformUserInfo *)response platform:(PTThirdPlatformType)platform {
    PTThirdPlatformOnMainThreadAsync(^{
        !_callback ?: _callback(response, nil);
    });
}

- (void)respManagerDidRecvMessageResponse:(BOOL)result platform:(PTShareType)platform {
    PTThirdPlatformOnMainThreadAsync(^{
        if (result) {
            !self.shareResultBlock ?: self.shareResultBlock(platform, PTShareResultSuccess, nil);
        } else {
            !self.shareResultBlock ?: self.shareResultBlock(platform, PTShareResultFailed, nil);
        }
    });
}

- (void)respManagerDidRecvPayResponse:(BOOL)result platform:(PTThirdPlatformType)platform {
    PTThirdPlatformOnMainThreadAsync(^{
        !self.paymentBlock ?: self.paymentBlock(result);
    });
}

@end
