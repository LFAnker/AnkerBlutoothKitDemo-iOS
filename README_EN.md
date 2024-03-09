[English Docs](README_EN.md) | [Chinese Docs](README.md)

# AnkerBluetoothKit iOS SDK

AnkerBluetoothKit is an SDK packaged for eufy T9148/eufy T9149, including Bluetooth connection logic, data analysis logic, and body fat calculation.

### Sample program

In order to allow customers to quickly implement weighing and corresponding functions, a sample program is provided, which includes a body fat calculation module and a device function module.

- The devices currently supported by the device function module include: eufy T9148/eufy T9149 series Bluetooth WiFi body fat scale.
- The body fat calculation module supports 4-electrode AC algorithm.

## Ⅰ. Integration method

#### 1.1 Copy `AnkerBluetoothKit` to the main directory of the project, add `AnkerBluetoothKit` in the `Podfile` file, and execute `pod install`

```
pod 'AnkerBluetoothKit',:path=>'./AnkerBluetoothKit'
```

#### 1.2 Add Bluetooth permissions in the `Info.plist` file

```
<key>NSBluetoothAlwaysUsageDescription</key>

<string>Your consent is required to connect devices using Bluetooth</string>

<key>NSBluetoothPeripheralUsageDescription</key>

<string>Your consent is required to connect devices using Bluetooth</string>
```

## Ⅱ .Instructions for use

#### 1.1 Operating environment

Due to the need for Bluetooth connection, the Demo needs to be run on a real machine and supports iOS9.0 and above systems.

### 1.2 Conventions related to measuring body data

#### 1.2.1 Precautions for weighing and fat measurement

- The scale supports fat measurement
- Weigh on your bare feet and touch the corresponding electrode pads
- The weighing interface returns weight (kg) and impedance information
- Human body parameters height and age are entered correctly

#### 1.2.2 Body fat calculation

##### Basic parameter agreement

| Category | Input Range | Units |
|:----|:--------|:--:|
| Height | 100-220 | cm |
| Age | 10-99 | Years |
| Gender| 0/1 | Female/Male|
| Weight | 10-200 | kg |


- Height, age, gender and corresponding impedance are required, and the corresponding calculation library is called to obtain them.
- The body fat data items involved in 8-electrode require an 8-electrode scale to be used.

## Ⅲ. Calculate body fat - calculate - CalcuteInfoViewController

### 1.1 Description of parameters required for body fat calculation

Based on the weight and impedance parsed by the Bluetooth protocol, plus the height, age, and gender of the user data, multiple body fat parameter information such as body fat rate is calculated.

#### 1.1.1 AKBluetoothScaleBaseModel

| Parameters | Comments | Description |
| :-------- | :----- | :----: |
| weight | weight | actual weight * rounded to 100 |
|impedance|4-electrode algorithm impedance (encryption) |4-electrode algorithm field|
| isHeartRating| Whether heart rate is being measured|Heart rate measurement status|
| unit | Current unit of the scale | Real-time unit |
| heartRate| Heart rate|The scale supports heart rate validation|
| dataType| Data class|AKScaleDataTypeStable = 0, // Stable weight data, AKScaleDataTypeDynamic = 1, // Dynamic weight data, AKScaleDataTypeOverweight = 2, // Overweight weight data, AKScaleDataTypeFat = 3, // with body fat percentage Lock weight, AKScaleDataTypePetAndBaby = 4, // Stable weight data in pet mode/baby mode |


#### 1.1.2 Basic user information description AKBluetoothDeviceSettingModel

| Parameters | Comments | Description |
| :-------- | :----- | :----: |
| height| height|all body fat scales|
| age| age|all body fat scales|
| gender| Gender|All body fat scales|


### 1.3 Four-electrode AC body fat calculation - 4AC - CalcuelateResultViewController

**Four-electrode AC body fat calculation example:**

```
// Calculation result class: AKBodyFatModel

 

var fatModel:AKBodyFatModel!

        

fatModel = AKBodyFatModel(userModel: userModel,

deviceCalcuteType: PPDeviceCalcuteType.alternateNormal,

deviceMac: mac,

weight: weight,

heartRate: heartRate,

andImpedance: impedance)

                                       

// fatModel is the calculated result

if (fatModel.errorType == .ERROR_TYPE_NONE) {

 

	print("\(fatModel.description)")

} else {

 

	print("errorType:\(fatModel.errorType)")

}
```

## Ⅳ. Device scanning - Device-SearchDeviceViewController

### 1.2 Scan surrounding supported devices-SearchDeviceViewController

`AKBluetoothConnectManager` is the core class for device scanning and connection. It mainly implements the following functions:

- Bluetooth status monitoring
- Scan for supported Bluetooth devices in the surrounding area
- Connect to designated Bluetooth device
- Disconnect the specified device
- Stop scanning

```
@interface AKBluetoothConnectManager : NSObject

 

// Bluetooth status proxy

@property (nonatomic, weak) id<AKBluetoothUpdateStateDelegate> updateStateDelegate;

 

//Search for device agents

@property (nonatomic, weak) id<AKBluetoothSurroundDeviceDelegate> surroundDeviceDelegate;

 

//Connect device agent

@property (nonatomic, weak) id<AKBluetoothConnectDelegate> connectDelegate;

 

@property (nonatomic, weak) id<AKBluetoothScaleDataDelegate> scaleDataDelegate;

 

// Search for peripheral supported devices

- (void)searchSurroundDevice;

 

//Connect to the specified device

- (void)connectPeripheral:(CBPeripheral *)peripheral withDevice:(AKBluetoothAdvDeviceModel *)device;

 

// Stop searching for Bluetooth devices

- (void)stopSearch;

 

// Disconnect the specified Bluetooth device

- (void)disconnect:(CBPeripheral *)peripheral;

 

@end
```

#### 1.2.1 Create AKBluetoothConnectManager instance

```
//Create an AKBluetoothConnectManager instance and set the proxy

let scaleManager:AKBluetoothConnectManager = AKBluetoothConnectManager()

self.scaleManager.updateStateDelegate = self;

self.scaleManager.surroundDeviceDelegate = self;
```

#### 1.2.2 Implement Bluetooth status and search device agent methods

```
extension SearchDeviceViewController:AKBluetoothUpdateStateDelegate,AKBluetoothSurroundDeviceDelegate{

 

//Bluetooth status

func centralManagerDidUpdate(_ state: AKBluetoothState) {

        

if (state == .poweredOn){

self.scaleManager.searchSurroundDevice()

}

}

    

//Search for supported devices

func centralManagerDidFoundSurroundDevice(_ device: AKBluetoothAdvDeviceModel!, andPeripheral peripheral: CBPeripheral!) {

 

}

}
```

#### 1.2.3 AKBluetoothUpdateStateDelegate and AKBluetoothSurroundDeviceDelegate proxy method description

```
@protocol AKBluetoothUpdateStateDelegate <NSObject>

 

//Bluetooth status

- (void)centralManagerDidUpdateState:(AKBluetoothState)state;

 

@end

 

 

@protocol AKBluetoothSurroundDeviceDelegate <NSObject>

 

// Search for supported devices

- (void)centralManagerDidFoundSurroundDevice:(AKBluetoothAdvDeviceModel *)device andPeripheral:(CBPeripheral *)peripheral;

 

@end
```

#### 1.2.4 Bluetooth status description-AKBluetoothState

| Category enumeration | Description | Remarks |
|------|--------|--------|
| AKBluetoothStateUnknown | Unknown state |
| AKBluetoothStateResetting | Reset |
| AKBluetoothStateUnsupported | Not supported |
| AKBluetoothStateUnauthorized | Permission not authorized |
| AKBluetoothStatePoweredOff| Bluetooth is turned off|
| AKBluetoothStatePoweredOn | Bluetooth is on |


#### 1.2.5 Connect to the specified Bluetooth device

```
//Connect the Bluetooth device and set the corresponding proxy

self.scaleManager.connect(peripheral, withDevice: device)

self.scaleManager.connectDelegate = self
```

#### 1.2.6 Device connection status proxy implementation-AKBluetoothConnectDelegate

```
extension DeviceAnkerViewController:AKBluetoothConnectDelegate{

    

//The device is connected

func centralManagerDidConnect() {

 

}

    

//Device disconnects

func centralManagerDidDisconnect() {

 

}

    

//Device connection failed

func centralManagerDidFail(toConnect error: Error!) {

        

}

 

}
```

#### 1.2.7 Search for peripheral supported devices

```
// Search for peripheral supported devices. Please check whether Bluetooth is "on" before calling.

self.scaleManager.searchSurroundDevice()
```

#### 1.2.8 Stop scanning

```
self.scaleManager.stopSearch()
```

#### 1.2.9 Disconnect the specified device

```
self.scaleManager.disconnect(peripheral)
```

# Ⅴ. Function description

### 2.1 Function Description-DeviceAnkerViewController

#### 2.1.1 Supported functions

```
// AKBluetoothPeripheralAnker.h

 

@interface AKBluetoothPeripheralAnker : NSObject

 

@property (nonatomic, weak) id<AKBluetoothServiceDelegate> serviceDelegate;

 

@property (nonatomic, weak) id<AKBluetoothScaleDataDelegate> scaleDataDelegate;

 

@property (nonatomic, strong) CBPeripheral *peripheral;

 

@property (nonatomic, strong) AKBluetoothAdvDeviceModel *deviceAdv;

 

@property (nonatomic, strong) AKBatteryInfoModel *batteryInfo;

 

 

- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral andDevice:(AKBluetoothAdvDeviceModel *)device;

 

 

- (void)discoverFFF0Service;

 

 

/// Start authentication

/// - Parameter handler: 0 success 1 failure

- (void)startAuth:(void(^)(NSInteger status))handler;

 

 

/// Get battery power

- (void)fetchDeviceBatteryInfo;

 

/// Discover 180A device information service

- (void)discoverDeviceInfoService:(void(^)(AKBluetooth180ADeviceModel *deviceModel))deviceInfoResponseHandler;

 

/// Set unit

/// status 0 means success, 1 means failure

- (void)changeUnit:(PPDeviceUnit)unit withHandler:(void(^)(NSInteger status))handler;

 

/// Enter pregnant mode (safe mode)

/// status 0 means success, 1 means failure

- (void)enterPregnantWomanModeWithHandler:(void(^)(NSInteger status))handler;

 

/// Exit pregnant mode (safe mode)

/// status 0 means success, 1 means failure

- (void)exitPregnantWomanModeWithHandler:(void(^)(NSInteger status))handler;

 

/// Enter baby mode

/// status 0 means success, 1 means failure

- (void)enterBabyModeWithHandler:(void(^)(NSInteger status))handler;

 

/// Exit baby mode

/// status 0 means success, 1 means failure

- (void)exitBabyModeWithHandler:(void(^)(NSInteger status))handler;

 

/// Enter pet mode

/// status 0 means success, 1 means failure

- (void)enterPetModeWithHandler:(void(^)(NSInteger status))handler;

 

/// Exit pet mode

/// status 0 means success, 1 means failure

- (void)exitPetModeWithHandler:(void(^)(NSInteger status))handler;

 

/// Query the pregnant mode (safe mode) switch

/// status 0 means open, 1 means off, 2 means abnormal.

- (void)fetchPregnantWomanModeStatusWithHandler:(void(^)(NSInteger status))handler;

 

/// Switch mode (calibration/internal code)

/// status 0 means success, 1 means failure

- (void)switchMode:(AnkerSwitchMode)mode withHandler:(void(^)(NSInteger status))handler;

 

/// Turn on heart rate measurement

/// - Parameter handler: 0 set successfully 1 set failed

- (void)openHeartRateSwitch:(void(^)(NSInteger status))handler;

 

 

/// Turn off heart rate measurement

/// - Parameter handler: 0 set successfully 1 set failed

- (void)closeHeartRateSwitch:(void(^)(NSInteger status))handler;

 

/// reset

/// status 0 means success, 1 means failure

- (void)restoreFactoryWithHandler:(void(^)(NSInteger status))handler;

 

/// Get the heart rate switch status

/// heartRateStatus 0 on 1 off 2 abnormal

- (void)fetchHeartRateStatus:(void(^)(NSInteger heartRateStatus))handler;

 

 

/// Synchronize device time

/// status 0 means success, 1 means failure

- (void)syncTime:(void(^)(NSInteger status))handler;

 

 

/// Query device time

/// Example: 2017-08-17 21:04:48

- (void)fetchDeviceTime:(void(^)(NSString* deviceTime))handler;

 

/// Send user data

/// status 0 success 1 failure

- (void)syncUserInfo:(AKUserModel *)userModel withHandler:(void(^)(NSInteger status))handler;

 

 

/// Get historical data

/// - Parameter callBack:

- (void)fetchHistoryDataWithHandler:(void(^)(NSArray <AKBluetoothScaleBaseModel *>* history, NSError* error))handler;

 

 

/// Delete historical data

- (void)deleteDeviceHistoryDataWithHandler:(void(^)(NSInteger status))handler;

 

/// Search nearby WiFi list

- (void)findSurroundWIFI:(void(^)(NSArray <AKWifiInfoModel *>*wifis, int status))handler;

 

/// Cancel network configuration

/// status 0 success 1 failure

- (void)cancelWifiConfigWithHandler:(void(^)(NSInteger status))handler;

 

///Start network configuration

/// status 0 Started network configuration 1 Network configuration failed

- (void)startWifiWithHandler:(void(^)(NSInteger status))handler;

 

/// Issue the distribution network code, uid, and server domain name

/// status 0 success 1 failure

- (void)sendWifiCode:(NSString *)code uid:(NSString *)uid domain:(NSString *)domain handler:(void(^)(NSInteger status))handler;

 

///Issue domain name certificate

/// status 0 success 1 failure

- (void)sendCertificate:(NSString *)certificate withHandler:(void(^)(NSInteger status))handler;

 

/// Domain name certificate issuance completed

/// status 0 success 1 failure

- (void)sendCertificateCompleteWithHandler:(void(^)(NSInteger status))handler;

 

/// Update WiFi parameters (distribution network)-router name

/// status 0 success 1 failure

- (void)updateWifiSSID:(NSString *)ssid withHandler:(void(^)(NSInteger status))handler;

 

/// Update WiFi parameters (distribution network)-router password

/// status 0 success 1 failure

- (void)updateWifiPassword:(NSString *)password withHandler:(void(^)(NSInteger status))handler;

 

/// Update WiFi parameters (network configuration) - end

/// status 0 success 1 failure

/// step: Current step: WIFI prepares for network distribution - 0x11; delivers device id - 0x12; delivers product code - 0x13; network distribution start command - 0x14; receive domain name, uid - 0x15; receive certificate - 0x16; receive certificate Completed - 0x17; WIFI list - 0x18; Receive SSID - 0x19; Receive password - 0x1A; Network configuration completion command - 0x1B; Delete WIFI parameters - 0x1C; Connect to router - 0x25

/// errorType: timeout - 0x01; received wifi error code - 0x02; received res_code error code returned by the cloud - 0x0d

- (void)updateWifiInfoCompleteWithHandler:(void(^)(NSInteger status, Byte step, Byte errorType))handler;

 

@end
```

## Ⅵ. Entity class objects and specific parameter descriptions

### 1.1 AKBodyFatModel body fat calculation object parameter description

24 items of data corresponding to four electrodes

| Parameters | Parameter type | Description | Data type | Remarks|
|------|--------|--------|--------|--------|
|ppBodyBaseModel| AKBluetoothDeviceSettingModel |Input parameters for body fat calculation|Basic input parameters|Contains device information, user basic information, weight and heart rate|Body fat scale|
|ppSDKVersion| String |Computation library version number|Return parameters|  |
|ppSex| PPUserGender|Gender|Return parameters| PPUserGenderFemale female PPUserGenderMale male|
|ppHeightCm|Int |Height|Return parameters|cm|
|ppAge|Int |Age|Return Parameters|Years|
|errorType|BodyFatErrorType |Error type|Return parameters|PP_ERROR_TYPE_NONE(0), no error PP_ERROR_TYPE_AGE(1), age error PP_ERROR_TYPE_HEIGHT(2), height error PP_ERROR_TYPE_WEIGHT(3), weight error PP_ERROR_TYPE_SEX(4) gender error PP_ERROR_TYPE_PEOPLE_TYPE (5) The following impedance is incorrect PP_ERROR_TYPE_IMPEDANCE_TWO_LEGS(6) PP_ERROR_TYPE_IMPEDANCE_TWO_ARMS(7)PP_ERROR_TYPE_IMPEDANCE_LEFT_BODY(8) PP_ERROR_TYPE_IMPEDANCE_RIGHT_ARM(9)PP_ERROR_TYPE_IMPEDANCE_LEFT_ARM(10) PP_ER ROR_TYPE_IMPEDANCE_LEFT_LEG(11) PP_ERROR_TYPE_IMPEDANCE_RIGHT_LEG(12) PP_ERROR_TYPE_IMPEDANCE_TRUNK(13)|
|bodyDetailModel|PPBodyDetailModel|Data interval range and introduction description|
|ppWeightKg|Float |Weight|24&48|kg|
|ppBMI|Float|Body Mass Index|24&48|
|ppFat|Float |Fat rate|24&48|%|
|ppBodyfatKg|Float |Fat mass|24&48|kg|
|ppMusclePercentage|Float |Muscle Percentage|24&48|%|
|ppMuscleKg|Float |Muscle mass|24&48|kg|
|ppBodySkeletal|Float |Skeletal muscle rate|24&48|%|
|ppBodySkeletalKg|Float |Skeletal muscle mass|24&48|kg|
|ppWaterPercentage|Float |Moisture percentage|24&48|%|
|ppWaterKg|Float |Moisture content|24&48|kg|
|ppProteinPercentage|Float |Protein rate|24&48|%|
|ppProteinKg|Float |Protein mass|24&48|kg|
|ppLoseFatWeightKg|Float |Lean body mass|24&48|kg
|ppBodyFatSubCutPercentage|Float |Subcutaneous fat rate|24&48|%
|ppBodyFatSubCutKg|Float |Subcutaneous fat mass|24&48|kg
|ppHeartRate|Int |Heart rate|24&48|bmp This value is related to the scale, and is valid if it is greater than 0
|ppBMR|Int |Basal Metabolism|24&48|
|ppVisceralFat|Int |Visceral fat level|24&48|
|ppBoneKg|Float |Bone mass|24&48|kg
|ppBodyMuscleControl|Float |Muscle control volume|24&48|kg
|ppFatControlKg|Float |Fat control volume|24&48|kg
|ppBodyStandardWeightKg|Float |Standard weight|24&48|kg
|ppIdealWeightKg|Float |Ideal Weight|24&48|kg
|ppControlWeightKg|Float |Control weight|24&48|kg
|ppBodyType|PPBodyDetailType |Body type|24&48|PPBodyDetailType has a separate description
|ppFatGrade|PPBodyFatGrade|Obesity grade|24&48|PPBodyGradeFatThin(0), //!< Thin PPBodyGradeFatStandard(1),//!< Standard PPBodyGradeFatOverwight(2), //!< Overweight PPBodyGradeFatOne(3),//!< Obesity level 1PPBodyGradeFatTwo(4),//!< Obesity level 2PPBodyGradeFatThree(5);//!< Obesity level 3
|ppBodyHealth|PPBodyHealthAssessment |Health Assessment|24&48|PPBodyAssessment1(0), //!< Hidden health risks PPBodyAssessment2(1), //!< Sub-health PPBodyAssessment3(2), //!< General PPBodyAssessment4(3), // !< GoodPPBodyAssessment5(4); //!< Very good
|ppBodyAge|Int|Body Age|24&48|Years
|ppBodyScore|Int |Body Score|24&48|Points

Note: To get the object when using it, please call the corresponding attribute to get the corresponding value.

### 1.2 Body type-PPBodyDetailType

| Parameters | Description | type |
|------|--------|--------|
|PPBodyTypeThin|Thin type|0|
|PPBodyTypeThinMuscle|Thin Muscle|1|
|PPBodyTypeMuscular|Muscular|2|
|PPBodyTypeLackofexercise|Lack of exercise|3|
|PPBodyTypeStandard|Standard type|4|
|PPBodyTypeStandardMuscle|Standard muscle type|5|
|PPBodyTypeObesFat|Puffy and obese type|6|
|PPBodyTypeFatMuscle|Fat muscular type|7|
|PPBodyTypeMuscleFat|Muscle type fat|8|

### 1.3 Device object-AKBluetoothAdvDeviceModel

|Attribute name|Type|Description|Remarks|
| ------ | ---- | ---- | ---- |
| deviceMac | String | device mac|device unique identifier|
| deviceName | String | Device Bluetooth name | Device name identification |
| rssi | Int | Bluetooth signal strength |

### 1.4 Device unit-PPDeviceUnit

|enum type|type|unit|
| ---- | ---- |---- |  
|PPUnitKG| 0 | KG |  
|PPUnitLB| 1 | LB |  
|PPUnitSTLB| 2 | ST_LB |  
|PPUnitJin| 3 | 斤 |  
|PPUnitG| 4 | g |  
|PPUnitLBOZ| 5 | lb:oz |  
|PPUnitOZ| 6 | oz |  
|PPUnitMLWater| 7 | ml（水） |  
|PPUnitMLMilk| 8 | ml（牛奶） |  
|PPUnitFLOZWater| 9 | fl_oz（水） |  
|PPUnitFLOZMilk| 10 | fl_oz（牛奶） |  
|PPUnitST| 11 | ST |
