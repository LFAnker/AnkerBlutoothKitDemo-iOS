//
//  AKBluetoothPeripheralAnker.h
//  AnkerBluetoothKit
//
//  Created by lefu on 2023/9/6.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "AKBluetoothAdvDeviceModel.h"
#import "AKBluetooth180ADeviceModel.h"
#import "AKBluetoothInterface.h"
#import "AKBluetoothDeviceSettingModel.h"
#import "AKScaleFormatTool.h"
#import "AKBluetoothCMDAnker.h"
#import "AKBluetoothPeripheralAnker.h"
#import "AKWifiInfoModel.h"
#import "AKBatteryInfoModel.h"
#import "AKAESTool.h"
#import "AKUserModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AnkerSwitchMode) {
    AnkerSwitchModeInternalCode = 0, // 标定
    AnkerSwitchModeCalibration, // 内码
};

typedef NS_ENUM(NSUInteger, AnkerWifierrorType) {
    AnkerWifierrorTypeNormal, // 正常
    AnkerWifierrorTypeTimeout = 1, // 超时
    AnkerWifierrorTypeWifiError = 2, // 接收到wifi错误码
    AnkerWifierrorTypeServerError = 13, // 接收到云端返回res_code错误码
};

@interface AKBluetoothPeripheralAnker : NSObject

@property (nonatomic, weak) id<AKBluetoothServiceDelegate> serviceDelegate;

@property (nonatomic, weak) id<AKBluetoothScaleDataDelegate> scaleDataDelegate;

@property (nonatomic, strong) CBPeripheral *peripheral;

@property (nonatomic, strong) AKBluetoothAdvDeviceModel *deviceAdv;

@property (nonatomic, strong) AKBatteryInfoModel *batteryInfo;


- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral  andDevice:(AKBluetoothAdvDeviceModel *)device;


- (void)discoverFFF0Service;


/// 开始鉴权
/// - Parameter handler:  0 成功 1 失败
- (void)startAuth:(void(^)(NSInteger status))handler;


/// 获取电池电量
- (void)fetchDeviceBatteryInfo;

/// 发现180A设备信息服务
- (void)discoverDeviceInfoService:(void(^)(AKBluetooth180ADeviceModel *deviceModel))deviceInfoResponseHandler;

/// 设置单位
/// status 0 为成功 1为失败
- (void)changeUnit:(PPDeviceUnit)unit withHandler:(void(^)(NSInteger status))handler;

/// 进入孕妇模式（安全模式）
/// status 0 为成功 1为失败
- (void)enterPregnantWomanModeWithHandler:(void(^)(NSInteger status))handler;

/// 退出孕妇模式（安全模式）
/// status 0 为成功 1为失败
- (void)exitPregnantWomanModeWithHandler:(void(^)(NSInteger status))handler;

/// 进入婴儿模式
/// status 0 为成功 1为失败
- (void)enterBabyModeWithHandler:(void(^)(NSInteger status))handler;

/// 退出婴儿模式
/// status 0 为成功 1为失败
- (void)exitBabyModeWithHandler:(void(^)(NSInteger status))handler;

/// 进入宠物模式
/// status 0 为成功 1为失败
- (void)enterPetModeWithHandler:(void(^)(NSInteger status))handler;

/// 退出宠物模式
/// status 0 为成功  1为失败
- (void)exitPetModeWithHandler:(void(^)(NSInteger status))handler;

/// 查询孕妇模式（安全模式）开关
/// status 0 为开  1为关  2为异常
- (void)fetchPregnantWomanModeStatusWithHandler:(void(^)(NSInteger status))handler;

/// 切换模式（标定/内码）
/// status 0 为成功 1为失败
- (void)switchMode:(AnkerSwitchMode)mode withHandler:(void(^)(NSInteger status))handler;

/// 打开心率测量
/// - Parameter handler: 0设置成功 1设置失败
- (void)openHeartRateSwitch:(void(^)(NSInteger status))handler;


/// 关闭心率测量
/// - Parameter handler:  0设置成功 1设置失败
- (void)closeHeartRateSwitch:(void(^)(NSInteger status))handler;

/// 恢复出厂设置
/// status 0 为成功 1为失败
- (void)restoreFactoryWithHandler:(void(^)(NSInteger status))handler;

/// 获取心率开关状态
/// heartRateStatus 0开  1关 2异常
- (void)fetchHeartRateStatus:(void(^)(NSInteger heartRateStatus))handler;


/// 同步设备时间
///  status 0 为成功 1为失败
- (void)syncTime:(void(^)(NSInteger status))handler;


/// 查询设备时间
///  例：2017-08-17 21:04:48
- (void)fetchDeviceTime:(void(^)(NSString* deviceTime))handler;

/// 下发用户数据
/// status 0成功  1失败
- (void)syncUserInfo:(AKUserModel *)userModel withHandler:(void(^)(NSInteger status))handler;


/// 获取历史数据
/// - Parameter callBack:
- (void)fetchHistoryDataWithHandler:(void(^)(NSArray <AKBluetoothScaleBaseModel *>* history, NSError* error))handler;


/// 删除历史数据
- (void)deleteDeviceHistoryDataWithHandler:(void(^)(NSInteger status))handler;

/// 搜索附近WiFi列表
- (void)findSurroundWIFI:(void(^)(NSArray <AKWifiInfoModel *>*wifis, int status))handler;

/// 取消配网
/// status 0成功  1失败
- (void)cancelWifiConfigWithHandler:(void(^)(NSInteger status))handler;

/// 开始配网
/// status 0开始配网  1配网失败
- (void)startWifiWithHandler:(void(^)(NSInteger status))handler;

/// 下发配网code、uid、服务器域名
/// status 0成功  1失败
- (void)sendWifiCode:(NSString *)code uid:(NSString *)uid domain:(NSString *)domain handler:(void(^)(NSInteger status))handler;

/// 下发域名证书
/// status 0成功  1失败
- (void)sendCertificate:(NSString *)certificate withHandler:(void(^)(NSInteger status))handler;

/// 下发域名证书完成
/// status 0成功  1失败
- (void)sendCertificateCompleteWithHandler:(void(^)(NSInteger status))handler;

/// 更新WiFi参数(配网)-路由器名称
/// status 0成功  1失败
- (void)updateWifiSSID:(NSString *)ssid withHandler:(void(^)(NSInteger status))handler;

/// 更新WiFi参数(配网)-路由器密码
/// status 0成功  1失败
- (void)updateWifiPassword:(NSString *)password withHandler:(void(^)(NSInteger status))handler;

/// 更新WiFi参数(配网)-结束
/// status 0成功  1失败
/// step : 当前步骤：WIFI准备配网 - 0x11；下发device id - 0x12；下发product code - 0x13；配网开始指令 - 0x14；接收域名、uid - 0x15；接收证书 - 0x16；证书接收完成 - 0x17；WIFI list-  0x18；接收SSID - 0x19；接收password - 0x1A；配网完成指令 - 0x1B；删除WIFI参数 - 0x1C；连接路由器-0x25
/// errorType: 超时 - 0x01；接收到wifi错误码 - 0x02；接收到云端返回res_code错误码 - 0x0d
- (void)updateWifiInfoCompleteWithHandler:(void(^)(NSInteger status, Byte step, Byte errorType))handler;

@end

NS_ASSUME_NONNULL_END
