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

@property (nonatomic, weak) id<AKBluetoothUpdateStateDelegate> updateStateDelegate;

@property (nonatomic, weak) id<AKBluetoothSurroundDeviceDelegate> surroundDeviceDelegate;

@property (nonatomic, weak) id<AKBluetoothConnectDelegate> connectDelegate;

@property (nonatomic, weak) id<AKBluetoothScaleDataDelegate> scaleDataDelegate;

- (void)searchSurroundDevice;


- (void)connectPeripheral:(CBPeripheral *)peripheral withDevice:(AKBluetoothAdvDeviceModel *)device;

- (void)stopSearch;

- (void)disconnect:(CBPeripheral *)peripheral;

@end

NS_ASSUME_NONNULL_END
