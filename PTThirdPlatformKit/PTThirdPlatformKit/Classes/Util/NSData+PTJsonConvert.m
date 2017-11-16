//
//  NSData+PTJsonConvert.m
//  Pods
//
//  Created by aron on 2017/11/16.
//
//

#import "NSData+PTJsonConvert.h"

@implementation NSData (PTJsonConvert)

- (id)nsjsonObject {
    NSError *JSONSerializationError;
    id obj = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingAllowFragments error:&JSONSerializationError];
    
    if (JSONSerializationError) {
        NSLog(@"-NSJSONObject JSON Serialization Error is: %@", JSONSerializationError);
    }
    return obj;
}

@end
