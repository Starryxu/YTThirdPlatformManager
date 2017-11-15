//
//  PTThirdPlatformObject.m
//  Plush
//
//  Created by aron on 2017/10/24.
//  Copyright © 2017年 qingot. All rights reserved.
//

#import "PTThirdPlatformObject.h"

@implementation ThirdPlatformUserInfo

@end


@implementation PTSharedObject

@end


@implementation PTSharedVideoObject

@end


@implementation PTSharedWebPageObject

@end


@implementation ThirdPlatformShareModel

@end


@implementation ThirdPlatformLoginModel

@end

@implementation OrderModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"orderID" : @"oId",
             @"sign": @[@"sign", @"body"],
             };
}
@end

