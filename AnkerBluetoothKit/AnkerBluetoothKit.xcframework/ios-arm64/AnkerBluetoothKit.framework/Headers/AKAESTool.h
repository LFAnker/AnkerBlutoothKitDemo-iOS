//
//  AKAESTool.h
//  AnkerBluetoothKitDemo
//
//  Created by lefu on 2023/12/2
//


#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>


@interface AKAESTool:NSObject



+ (NSData *)encryptData:(NSString *)dataText keyData:(NSData *)keyData ivString:(NSString *)ivString;

+ (NSData *)decryptData:(NSData *)encryptedData keyData:(NSData *)keyData ivString:(NSString *)ivString;

@end

