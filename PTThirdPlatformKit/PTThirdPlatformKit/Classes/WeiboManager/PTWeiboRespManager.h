//
//  PTWeiboRespManager.h
//  Plush
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 qingot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTBaseThirdPlatformRespManager.h"
#import <WeiboSDK/WeiboSDK.h>

@interface PTWeiboRespManager : PTBaseThirdPlatformRespManager <WeiboSDKDelegate>

AS_SINGLETON

@end
