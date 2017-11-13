//
//  PTThirdPlatformConfigurable.h
//  Pods
//
//  Created by aron on 2017/11/13.
//
//

#import <Foundation/Foundation.h>
#import "PTThirdPlatformDefine.h"

@protocol PTThirdPlatformConfigurable <NSObject>

/**
 *  设置平台的appkey
 *
 *  @param platformType 平台类型 @see PTThirdPlatformType
 *  @param appKey       第三方平台的appKey
 *  @param appID        第三方平台的appID
 *  @param appSecret    第三方平台的appSecret
 *  @param redirectURL  redirectURL
 */
- (BOOL)setPlaform:(PTThirdPlatformType)platformType
             appID:(NSString *)appID
            appKey:(NSString *)appKey
         appSecret:(NSString *)appSecret
       redirectURL:(NSString *)redirectURL;

- (NSString*)appIDWithPlaform:(PTThirdPlatformType)platformType;
- (NSString*)appKeyWithPlaform:(PTThirdPlatformType)platformType;
- (NSString*)appSecretWithPlaform:(PTThirdPlatformType)platformType;
- (NSString*)appRedirectURLWithPlaform:(PTThirdPlatformType)platformType;

@end
