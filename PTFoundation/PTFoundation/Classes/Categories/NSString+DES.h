//
//  NSString+DES.h
//  mmosite
//
//  Created by yuan he on 2017/4/1.
//  Copyright © 2017年 qingot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DES)

- (NSString *)desEncrypt:(NSString *)key;
- (NSString *)desDecrypt:(NSString *)key;
+ (NSString *)mm_hexStringFromData:(NSData *)data;

@end
