//
//  NSString+NSJSON.m
//  MobileExperience
//
//  Created by Fyl on 16/1/18.
//  Copyright (c) 2016 xzrs. All rights reserved.
//

#import "NSString+NSJSON.h"

@implementation NSString (NSJSON)

- (id)nsjsonObject
{
    NSError *JSONSerializationError;
    id obj = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&JSONSerializationError];
    
    if (JSONSerializationError) {
        NSLog(@"-NSJSONObject JSON Serialization Error is: %@", JSONSerializationError);
    }
    return obj;
}

@end
