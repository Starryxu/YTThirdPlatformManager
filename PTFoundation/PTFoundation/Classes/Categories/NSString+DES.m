//
//  NSString+DES.m
//  mmosite
//
//  Created by yuan he on 2017/4/1.
//  Copyright © 2017年 qingot. All rights reserved.
//

#import "NSString+DES.h"
#import <CommonCrypto/CommonCryptor.h>
#import "NSData+Base64.h"

@implementation NSString (DES)

- (NSString *)desEncrypt:(NSString *)key {
    if (key.length < kCCKeySizeDES) {
        return @"";
    }
    NSString *ciphertext = nil;
    // fetch key data
    if(key.length>kCCKeySizeDES) {
        key = [key substringToIndex:kCCKeySizeDES];
    }
    
    char keyPtr[kCCKeySizeDES + 1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    Byte iv[9];
    bzero(iv, sizeof(iv));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    [key getCString:iv maxLength:sizeof(iv) encoding:NSUTF8StringEncoding];
    
    
    NSData *dataSource = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [dataSource length];
    
    size_t bufferSize           = dataLength + kCCBlockSizeDES + 100;
    void* buffer                = malloc(bufferSize);
    
    size_t numBytesEncrypted    = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeDES,
                                          iv, /* initialization vector (optional) */
                                          [dataSource bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    
    //    NSLog(@"%d,%d",dataLength, (int)numBytesEncrypted);
    if (cryptStatus == kCCSuccess && numBytesEncrypted <= bufferSize) {
        NSData *data = [NSData dataWithBytesNoCopy:buffer length:(NSUInteger)numBytesEncrypted freeWhenDone:NO];
        NSString *encryptedString = [NSString mm_hexStringFromData:data];
        ciphertext = [[encryptedString dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
    }
    free(buffer);
    return ciphertext;
}

+ (NSString *)mm_hexStringFromData:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange,BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i =0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) &0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}

+ (NSMutableData *)dataFromHexString:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] %2 == 0) {
        range = NSMakeRange(0,2);
    } else {
        range = NSMakeRange(0,1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
    return hexData;
}

- (NSString *)desDecrypt:(NSString *)key {
    if (key.length < kCCKeySizeDES) {
        return @"";
    }
    NSString *plaintext = nil;
    
    // fetch key data
    if(key.length>kCCKeySizeDES) {
        key = [key substringToIndex:kCCKeySizeDES];
    }
    
    char keyPtr[kCCKeySizeDES + 1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    Byte iv[9];
    bzero(iv, sizeof(iv));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    [key getCString:iv maxLength:sizeof(iv) encoding:NSUTF8StringEncoding];
    
    NSData *decodedData = [NSData dataFromBase64String:self];
    NSString *cipherString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    NSData *cipherData = [NSString dataFromHexString:cipherString];
    
    unsigned char buffer[self.length];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes], [cipherData length],
                                          buffer, self.length,
                                          &numBytesDecrypted);
    if(cryptStatus == kCCSuccess) {
        NSData *plaindata = [NSData dataWithBytesNoCopy:buffer length:(NSUInteger)numBytesDecrypted freeWhenDone:NO];
        plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
    }
    return plaintext;
}

@end
