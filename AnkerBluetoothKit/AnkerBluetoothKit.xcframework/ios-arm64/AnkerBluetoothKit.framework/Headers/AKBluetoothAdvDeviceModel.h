//
//  AKBluetoothAdvDeviceModel.h
//  AnkerBluetoothKit
//
//  Created by 彭思远 on 2023/4/1.
//

#import <Foundation/Foundation.h>
#import "AnkerBluetoothDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface AKBluetoothAdvDeviceModel : NSObject

@property (nonatomic, copy) NSString *deviceName;
@property (nonatomic, copy) NSString *deviceMac;
@property (nonatomic, assign) NSInteger rssi;

@end

NS_ASSUME_NONNULL_END
