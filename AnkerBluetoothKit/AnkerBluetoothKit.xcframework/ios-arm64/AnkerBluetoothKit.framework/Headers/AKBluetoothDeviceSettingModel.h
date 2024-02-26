//
//  AKBluetoothDeviceSettingModel.h
//  AnkerBluetoothKit
//
//  Created by 彭思远 on 2023/4/3.
//

#import <Foundation/Foundation.h>
#import "AnkerBluetoothDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface AKBluetoothDeviceSettingModel : NSObject

@property (nonatomic, assign) BOOL isPregnantMode;
@property (nonatomic, assign) BOOL isAthleteMode;
@property (nonatomic, assign) PPDeviceUnit unit;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) PPDeviceGenderType gender;
@property (nonatomic, assign) NSInteger height;


@end

NS_ASSUME_NONNULL_END
