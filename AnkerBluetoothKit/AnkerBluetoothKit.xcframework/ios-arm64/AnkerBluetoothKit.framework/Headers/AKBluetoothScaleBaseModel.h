//
//  AKBluetoothScaleBaseModel.h
//  PPBlueToothDemo
//
//  Created by 彭思远 on 2020/7/31.
//  Copyright © 2020 彭思远. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnkerBluetoothDefine.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AKScaleDataType) {
    AKScaleDataTypeStable = 0, // 稳定的体重数据
    AKScaleDataTypeDynamic = 1, // 动态的体重数据
    AKScaleDataTypeOverweight = 2, // 超重的体重数据
    AKScaleDataTypeFat = 3, // 带体脂率的锁定重量
    AKScaleDataTypePetAndBaby = 4, // 宠物模式/抱婴模式下稳定的体重数据
};

typedef NS_ENUM(NSUInteger, AKScaleHeartRateStatus) {
    AKScaleHeartRateStatusNormal = 0, // 未开始
    AKScaleHeartRateStatusMeasure , //心率测量中
    AKScaleHeartRateStatusComplete, //心率测量完成
};

@interface AKBluetoothScaleBaseModel : NSObject

@property (nonatomic, assign) NSInteger weight; // 重量放大了100倍
@property (nonatomic, assign) AKScaleDataType dataType; //数据类型
@property (nonatomic, assign) NSInteger impedance; //4电极算法阻抗（明文）
@property (nonatomic, assign) PPDeviceUnit unit; //设备单位
@property (nonatomic, assign) NSInteger heartRate; // 心律
@property (nonatomic, assign) CGFloat fat; // 体脂率
@property (nonatomic, assign) BOOL isImpedanceTem; //是否明文阻抗
@property (nonatomic, assign) NSInteger impedanceEnCode;//阻抗加密值
@property (nonatomic, assign) AKScaleHeartRateStatus heartRateStatus; //心率测量状态
@property (nonatomic, copy) NSString *dateStr; // formate yyyy-MM-dd HH:mm:ss



@property (nonatomic, assign) BOOL isEnd; // 本次测量是否结束
@property (nonatomic, assign) BOOL isPowerOff; // 设备是否关机



@property (nonatomic, assign, readonly) double dateTimeInterval; // dataStr since1970的时间戳
@property (nonatomic, assign) BOOL isHeartRating; // 心律是否测量中
@property (nonatomic, assign) BOOL isFatting; // 体脂是否测量中
@property (nonatomic, assign) BOOL isOverload; // 是否超载
@property (nonatomic, assign) BOOL isPlus; // 是否是正数


@property (nonatomic, copy) NSString *memberId; //数据归属 torre协议用

@property (nonatomic, copy) NSString *calculateVersion; //FF1通道版本号 8电极torre协议用

@property (nonatomic, assign) NSInteger  z100KhzLeftArmEnCode;//100KHz左手阻抗加密值(下位机上传值)
@property (nonatomic, assign) NSInteger  z100KhzLeftLegEnCode;//100KHz左腳阻抗加密值(下位机上传值)
@property (nonatomic, assign) NSInteger  z100KhzRightArmEnCode;//100KHz右手阻抗加密值(下位机上传值)
@property (nonatomic, assign) NSInteger  z100KhzRightLegEnCode;//100KHz右腳阻抗加密值(下位机上传值)
@property (nonatomic, assign) NSInteger  z100KhzTrunkEnCode;//100KHz軀幹阻抗加密值(下位机上传值)
@property (nonatomic, assign) NSInteger  z20KhzLeftArmEnCode;//20KHz左手阻抗加密值(下位机上传值)
@property (nonatomic, assign) NSInteger  z20KhzLeftLegEnCode;//20KHz左腳阻抗加密值(下位机上传值)
@property (nonatomic, assign) NSInteger  z20KhzRightArmEnCode;//20KHz右手阻抗加密值(下位机上传值)
@property (nonatomic, assign) NSInteger  z20KhzRightLegEnCode;//20KHz右腳阻抗加密值(下位机上传值)
@property (nonatomic, assign) NSInteger  z20KhzTrunkEnCode;//20KHz軀幹阻抗加密值(下位机上传值)

@end

NS_ASSUME_NONNULL_END
