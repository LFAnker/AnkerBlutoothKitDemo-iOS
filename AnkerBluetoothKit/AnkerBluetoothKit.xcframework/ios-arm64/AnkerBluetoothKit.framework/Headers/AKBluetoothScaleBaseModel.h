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
@property (nonatomic, assign) NSInteger impedance; //4电极算法阻抗（加密）
@property (nonatomic, assign) PPDeviceUnit unit; //设备单位
@property (nonatomic, assign) NSInteger heartRate; // 心律
@property (nonatomic, assign) CGFloat fat; // 体脂率
@property (nonatomic, assign) BOOL isImpedanceTem; //是否明文阻抗
@property (nonatomic, assign) NSInteger impedanceTem;//明文阻抗值
@property (nonatomic, assign) AKScaleHeartRateStatus heartRateStatus; //心率测量状态
@property (nonatomic, copy) NSString *dateStr; // formate yyyy-MM-dd HH:mm:ss

@property (nonatomic, assign) BOOL isHeartRating; // 心律是否测量中
@property (nonatomic, assign) BOOL isOverload; // 是否超载



@end

NS_ASSUME_NONNULL_END
