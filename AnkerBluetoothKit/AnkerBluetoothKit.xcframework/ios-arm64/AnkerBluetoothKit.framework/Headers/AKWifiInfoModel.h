//
//  AKWifiInfoModel.h
//  AnkerBluetoothKit
//
//  Created by 彭思远 on 2023/4/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AKWifiInfoModel : NSObject

@property (nonatomic, copy) NSString *ssid;
@property (nonatomic, assign) NSInteger rssi;
@property (nonatomic, assign) NSInteger strength;
@property (nonatomic, copy) NSString *bSSID;
@property (nonatomic, copy) NSString *password;


@end

NS_ASSUME_NONNULL_END
