//
//  AKBluetoothAnkerDataAnalysis.h
//  AnkerBluetoothKit
//
//  Created by lefu on 2023/9/6.
//

#import <Foundation/Foundation.h>
#import "AKBluetoothScaleBaseModel.h"
#import "AKWifiInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AnkerConventionStaus) {
    AnkerConventionStausSuccess = 0, // 成功
    AnkerConventionStausFail, //失败

};

typedef NS_ENUM(NSUInteger, AnkerPregnantWomanModeStatus) {
    AnkerPregnantWomanModeStatusOpen = 0,
    AnkerPregnantWomanModeStatusClose,
    AnkerPregnantWomanModeStatusException,
};

@interface AKBluetoothAnkerDataAnalysis : NSObject

+ (NSData *)getDataWithPackage:(NSData *)packageData;

+ (AnkerConventionStaus)analysisConventionCMD:(Byte)cmd resultData:(NSData *)data;

+ (AnkerPregnantWomanModeStatus)analysisPregnantWomanModeWithData:(NSData *)data;

+ (AKBluetoothScaleBaseModel *)analysisData:(NSData *)receiveData isHistory:(BOOL)isHistory;

+ (NSString *)analysisTimeWithData:(NSData *)data;

+ (NSArray<AKWifiInfoModel *> *)analysisWifiWithData:(NSData *)data;


@end

NS_ASSUME_NONNULL_END
