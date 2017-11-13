//
//  PTAlipayRespManager.h
//  Plush
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 qingot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTBaseThirdPlatformRespManager.h"

@interface PTAlipayRespManager : PTBaseThirdPlatformRespManager

AS_SINGLETON

// 设置响应结果
- (void)setResponse:(NSDictionary*)response;

@end
