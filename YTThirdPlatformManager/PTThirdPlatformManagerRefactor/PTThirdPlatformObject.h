//
//  PTThirdPlatformObject.h
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/24.
//  Copyright © 2017年 aron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTThirdPlatformDefine.h"

@interface PTThirdPlatformObject : NSObject

@end


#pragma mark - ......::::::: ThirdPlatformUserInfo :::::::......

@interface ThirdPlatformUserInfo : NSObject
@property (nonatomic, assign) PTThirdPlatformType thirdPlatformType;
@property (nonatomic, copy) NSString* username;
@property (nonatomic, copy) NSString* userId;
@property (nonatomic, copy) NSString* email;
@property (nonatomic, copy) NSString* head;
@property (nonatomic, copy) NSString* age;
@property (nonatomic, copy) NSString* gender;
@property (nonatomic, strong) NSDate* expirationDate;
@property (nonatomic, strong) NSString* tokenString;

+ (ThirdPlatformUserInfo *)userbyTranslateSinaResult:(id)result;
+ (ThirdPlatformUserInfo *)userbyTranslateTencentResult:(id)result;

@end
