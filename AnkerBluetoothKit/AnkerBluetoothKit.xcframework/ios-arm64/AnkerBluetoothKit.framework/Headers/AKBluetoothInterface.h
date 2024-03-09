//
//  AKBluetoothInterface.h
//  AnkerBluetoothKit
//
//  Created by 彭思远 on 2023/3/27.
//

#ifndef PPBluetoothInterface_h
#define PPBluetoothInterface_h


#import "AnkerBluetoothDefine.h"

@class AKBluetoothAdvDeviceModel;
@class CBPeripheral;
@class AKBluetoothScaleBaseModel;
@class AKBluetooth180ADeviceModel;
@class AKBodyFatModel;
@class AKBatteryInfoModel;

@protocol AKBluetoothUpdateStateDelegate <NSObject>

- (void)centralManagerDidUpdateState:(AKBluetoothState)state;

@end

@protocol AKBluetoothSurroundDeviceDelegate <NSObject>

- (void)centralManagerDidFoundSurroundDevice:(AKBluetoothAdvDeviceModel *)device andPeripheral:(CBPeripheral *)peripheral;
@end


@protocol AKBluetoothConnectDelegate <NSObject>

@optional

- (void)centralManagerDidConnect;

- (void)centralManagerDidFailToConnect:(NSError *)error;

- (void)centralManagerDidDisconnect;

@end


@protocol AKBluetoothServiceDelegate <NSObject>

- (void)discoverFFF0ServiceSuccess;

@end



@protocol AKBluetoothScaleDataDelegate <NSObject>

// 动态的体重数据
- (void)monitorProcessData:(AKBluetoothScaleBaseModel *)model advModel:(AKBluetoothAdvDeviceModel*)advModel;

// 稳定的体重数据
- (void)monitorLockData:(AKBluetoothScaleBaseModel*)model advModel:(AKBluetoothAdvDeviceModel*)advModel;

// 心率测量
// isComplete: YES 完成 ，  NO 测量中
- (void)monitorHeartRateData:(AKBluetoothScaleBaseModel*)model advModel:(AKBluetoothAdvDeviceModel*)advModel isComplete:(BOOL)isComplete;

// 抱婴或宠物模式 稳定数据
- (void)monitorBabyPetLockData:(AKBluetoothScaleBaseModel*)model advModel:(AKBluetoothAdvDeviceModel*)advModel;

// 超重
- (void)monitorOverWeight:(AKBluetoothScaleBaseModel*)model advModel:(AKBluetoothAdvDeviceModel*)advModel;

@optional

- (void)monitorBatteryInfoChange:(AKBatteryInfoModel *)model advModel:(AKBluetoothAdvDeviceModel*)advModel;

@end


#endif /* PPBluetoothInterface_h */
