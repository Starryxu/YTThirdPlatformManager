//
//  PTThirdPlatformManager.h
//  Plush
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 qingot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTAbsThirdPlatformManager.h"
#import "PTThirdPlatformConfigurable.h"

@interface PTThirdPlatformManager : NSObject <PTAbsThirdPlatformManager, PTThirdPlatformConfigurable>

AS_SINGLETON

@end
