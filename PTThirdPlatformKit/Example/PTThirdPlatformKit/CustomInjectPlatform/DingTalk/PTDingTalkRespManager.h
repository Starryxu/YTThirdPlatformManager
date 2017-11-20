//
//  PTDingTalkRespManager.h
//  PTThirdPlatformKit
//
//  Created by aron on 2017/11/20.
//  Copyright © 2017年 flypigrmvb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTBaseThirdPlatformRespManager.h"
#import <DTShareKit/DTOpenKit.h>

@interface PTDingTalkRespManager : PTBaseThirdPlatformRespManager<DTOpenAPIDelegate>
AS_SINGLETON
@end
