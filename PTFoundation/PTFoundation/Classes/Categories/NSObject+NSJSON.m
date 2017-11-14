//
//  NSObject+NSJSON.m
//  MobileExperience
//
//  Created by Fyl on 16/1/18.
//  Copyright (c) 2016 xzrs. All rights reserved.
//

#import "NSObject+NSJSON.h"

@implementation NSObject (NSJSON)

//所有的对象必须是NSString、NSNumber、NSArray、NSDictionary、NSNull的实例
//所有NSDictionary的key必须是NSString类型
//数字对象不能是非数值或无穷

- (NSString *)nsjsonString
{
    if (![NSJSONSerialization isValidJSONObject:self]) {
        return nil;
    }
    NSError *error = NULL;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = @"";
    if ([jsonData length] && !error) {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    } else {
        NSLog(@"-NSJSONString failed. Error trace is: %@", error);
    }
    
    return jsonString;
}

@end
