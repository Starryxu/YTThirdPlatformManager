//
//  PTBaseThirdPlatformManager.h
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 aron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTAbsThirdPlatformManager.h"

@interface PTBaseThirdPlatformManager : NSObject <PTAbsThirdPlatformManager>

@property (nonatomic, copy) void (^paymentBlock)(BOOL result);
@property (nonatomic, copy) void (^callback)(ThirdPlatformUserInfo* userInfo, NSError* err);
@property (nonatomic, copy) void (^shareResultBlock)(PTShareType, PTShareResult, NSError *);


/**
 第三方分享，子类重写这个方法，由父类的shareToPlateform方法调用子类的该方法
 
 @param platform 第三方分享平台
 @param image 分享的图片
 @param imageUrlString 分享的图片地址
 @param title 分享的标题
 @param text 分享的文字
 @param urlString 分享的URL
 @param fromViewController 从哪个页面调用的分享
 @param shareResultBlock 分享结果回调
 */
- (void)doShareToPlateform:(PTShareType)platform
                   image:(UIImage*)image
          imageUrlString:(NSString*)imageUrlString
                   title:(NSString*)title
                    text:(NSString*)text
               urlString:(NSString*)urlString
      fromViewController:(UIViewController*)fromViewController
        shareResultBlock:(void (^) (PTShareType platform, PTShareResult shareResult, NSError* error))shareResultBlock;

@end
