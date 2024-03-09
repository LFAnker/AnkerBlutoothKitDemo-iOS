//
//  AKBluetoothConnectManager.h
//  AnkerBluetoothKit
//
//  Created by 彭思远 on 2023/3/30.
//

#import <Foundation/Foundation.h>
#import "AnkerBluetoothDefine.h"
#import "AKBluetoothInterface.h"
#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface AKBluetoothConnectManager : NSObject

// 蓝牙状态代理
@property (nonatomic, weak) id<AKBluetoothUpdateStateDelegate> updateStateDelegate;

// 搜索设备代理
@property (nonatomic, weak) id<AKBluetoothSurroundDeviceDelegate> surroundDeviceDelegate;

// 连接设备代理
@property (nonatomic, weak) id<AKBluetoothConnectDelegate> connectDelegate;

@property (nonatomic, weak) id<AKBluetoothScaleDataDelegate> scaleDataDelegate;

// 搜索周边所支持的设备
- (void)searchSurroundDevice;

// 连接指定的设备
- (void)connectPeripheral:(CBPeripheral *)peripheral withDevice:(AKBluetoothAdvDeviceModel *)device;

// 停止搜索蓝牙设备
- (void)stopSearch;

// 断开连接指定的蓝牙设备
- (void)disconnect:(CBPeripheral *)peripheral;

@end

NS_ASSUME_NONNULL_END
