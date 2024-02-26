//
//  DeviceAnkerViewController.swift
//  AnkerBluetoothKitDemo
//
//  Created by lefu on 2023/12/1
//  


import Foundation

enum menuType:String{

    case deviceInfo = "device info"
    case startMeasure = "start measure"
    case SyncTime = "Sync time"

    case FetchHistory = "Fetch History"
    case changeUnit = "Change unit"
    case clearDeviceData = "Clear DeviceData"
    case ScreenLuminance50 = "ScreenLuminance(50)"
    case ScreenLuminance100 = "ScreenLuminance(100)"
    case keepAlive = "keep connect alive"
    case wificonfigstatus = "wifi config"
    case distributionNetwork = "distribution network"
    case selectUser = "select user"
    case deleteUser = "delete user"

    case openHeartRate = "Open HeartRate"
    case closeHeartRate = "Close HeartRate"
    case openImpedance = "Open Impedance"
    case closeImpedance = "Close Impedance"
    case fetchDeviceTime = "Fetch DeviceTime"
    case fetchHeartRate = "Fetch Heart Rate"
    case enterBabyMode = "Enter Baby Mode"
    case exitBabyMode = "Exit Baby Mode"
    case enterPregnantWomanMode = "Enter Pregnant Woman Mode"
    case exitPregnantWomanMode = "Exit Pregnant Woman Mode"
    case enterPetMode = "Enter Pet Mode"
    case exitPetMode = "Exit Pet Mode"
    case fetchPregnantWomanMode = "Fetch Pregnant Woman Mode"
    case switchMode = "Switch Mode"
    case restoreFactory = "Restore Factory"
    case syncUserInfo = "Sync User Info"
    case deleteDeviceHistory = "Delete Device History"
    case fetchDeviceBatteryInfo = "Fetch Device Battery Info"
    case findSurroundWIFI = "Find Surround WIFI"
}

class DeviceAnkerViewController: BaseViewController {

    var XM_Anker: AKBluetoothPeripheralAnker?
    
    var scaleCoconutViewController:ScaleCoconutViewController?
    
    var array:[menuType] = [.deviceInfo,.startMeasure,.SyncTime, .fetchDeviceTime, .distributionNetwork,.changeUnit,.openHeartRate, .closeHeartRate, .fetchHeartRate, .enterBabyMode, .exitBabyMode, .enterPregnantWomanMode, .exitPregnantWomanMode, .enterPetMode, .exitPetMode, .fetchPregnantWomanMode, .switchMode, .restoreFactory, .syncUserInfo, .FetchHistory, .deleteDeviceHistory, .fetchDeviceBatteryInfo, .findSurroundWIFI]
    
    private var ankerMode:AnkerSwitchMode = .internalCode
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.XM_Anker?.scaleDataDelegate = self

    }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupBleManager()
        
        consoleView.layer.borderColor = UIColor.black.withAlphaComponent(0.4).cgColor
        
        consoleView.layer.borderWidth = 1
        
        consoleView.layer.cornerRadius = 12
        
        consoleView.layer.masksToBounds = true
        
        DispatchQueue.main.asyncAfter(wallDeadline: DispatchWallTime.now() + 2) {
            self.collectionView.reloadData()

        }
        
    }
    
    func setupBleManager(){
        
        self.scaleManager = AKBluetoothConnectManager()
        
        self.scaleManager.updateStateDelegate = self;
        
        self.scaleManager.surroundDeviceDelegate = self;
    }

    deinit {
        self.scaleManager.stopSearch()
        if let peripheral = self.XM_Anker?.peripheral{
            
            self.scaleManager.disconnect(peripheral)
        }
    }

}
 
extension DeviceAnkerViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let title = self.array[indexPath.row]
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
        
        
        cell.titleLbl.text = title.rawValue
        
        if title == .changeUnit{
            
            cell.titleLbl.text = "\(title.rawValue)(\(self.unit == PPDeviceUnit.unitKG ? "lb" : "kg"))"
        }
        
        if title == .startMeasure{
            
            cell.titleLbl.textColor = UIColor.green
            
        }else  if title == .distributionNetwork{
            cell.titleLbl.textColor = UIColor.red

        }else{
            cell.titleLbl.textColor = UIColor.black

        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSizeMake((UIScreen.main.bounds.size.width - 40) / 3, 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let title = self.array[indexPath.row]

        
        if !self.XM_IsConnect{
            
            self.addStatusCmd(ss: "device disconnect")

            return
        }
        
        if title == .startMeasure{

            self.scaleCoconutViewController = ScaleCoconutViewController.instantiate()
            self.navigationController?.pushViewController(self.scaleCoconutViewController!, animated: true)
            
            return
        }
        
        if title == .deviceInfo{
            
            self.addBleCmd(ss: "discoverDeviceInfoService")

            self.XM_Anker?.discoverDeviceInfoService({ [weak self] model in
                guard let `self` = self else {
                    return
                }
                
                self.addStatusCmd(ss: "\(model.modelNumber)")
                self.addStatusCmd(ss: "\(model.manufacturerName)")
                self.addStatusCmd(ss: "\(model.serialNumber)")
                self.addStatusCmd(ss: "\(model.hardwareRevision)")
            })
        }
        
        if title == .SyncTime{
            
            self.addBleCmd(ss: "codeSyncTime")
            
            self.XM_Anker?.syncTime({ [weak self] status in
                guard let `self` = self else {
                    return
                }
                
                self.addStatusCmd(ss: "\(status)")
            })
        }

        if title == .openHeartRate{
            
            self.addBleCmd(ss: "openHeartRateSwitch")

            self.XM_Anker?.openHeartRateSwitch({ [weak self] status in
                guard let `self` = self else {
                    return
                }
                
                self.addStatusCmd(ss: "\(status)")
            })
        }
        
        if title == .closeHeartRate{
            
            self.addBleCmd(ss: "closeHeartRateSwitch")

            self.XM_Anker?.closeHeartRateSwitch({ [weak self] status in
                guard let `self` = self else {
                    return
                }
                
                self.addStatusCmd(ss: "\(status)")
            })
        }
        
        if title == .fetchHeartRate{
            
            self.addBleCmd(ss: "fetchHeartRateStatus")

            self.XM_Anker?.fetchHeartRateStatus({ [weak self] status in
                guard let `self` = self else {
                    return
                }
                
                self.addStatusCmd(ss: "\(status)")
            })
        }
        
        if title == .FetchHistory{
            self.addBleCmd(ss: "dataFetchHistoryData")
            
            self.XM_Anker?.fetchHistoryData(handler: { [weak self] models, error in
                guard let `self` = self else {
                    return
                }
                
                models.forEach { bb in
                    
                    self.addStatusCmd(ss: "histroty---weight:\(bb.weight)")
                    
                }
            })
        }
        
        if title == .changeUnit{
            self.addBleCmd(ss: "change unit")

            self.unit = self.unit == PPDeviceUnit.unitKG ? PPDeviceUnit.unitLB  : PPDeviceUnit.unitKG
            
            self.XM_Anker?.change(self.unit, withHandler: { [weak self] status in
                guard let `self` = self else {
                    return
                }
                
                self.addStatusCmd(ss: "\(status)")
                
                self.collectionView.reloadData()
            })
        }

        
        if title == .enterPregnantWomanMode {
            self.addBleCmd(ss: "enterPregnantWomanMode")
            
            self.XM_Anker?.enterPregnantWomanMode(handler: { [weak self] status in
                guard let `self` = self else {
                    return
                }
                
                self.addStatusCmd(ss: "\(status)")
                
                self.collectionView.reloadData()
            })
        }
        
        if title == .exitPregnantWomanMode {
            self.addBleCmd(ss: "exitPregnantWomanMode")
            
            self.XM_Anker?.exitPregnantWomanMode(handler: { [weak self] status in
                guard let `self` = self else {
                    return
                }
                
                self.addStatusCmd(ss: "\(status)")
                
                self.collectionView.reloadData()
            })
        }
        
        if title == .enterBabyMode {
            self.addBleCmd(ss: "enterBabyMode")
            
            self.XM_Anker?.enterBabyMode(handler: { [weak self] status in
                guard let `self` = self else {
                    return
                }
                
                self.addStatusCmd(ss: "\(status)")
                
                self.collectionView.reloadData()
            })
        }
        
        if title == .exitBabyMode {
            self.addBleCmd(ss: "exitBabyMode")
            
            self.XM_Anker?.exitBabyMode(handler: { [weak self] status in
                guard let `self` = self else {
                    return
                }
                
                self.addStatusCmd(ss: "\(status)")
                
                self.collectionView.reloadData()
            })
        }
        
        if title == .enterPetMode {
            self.addBleCmd(ss: "enterPetMode")
            
            self.XM_Anker?.enterPetMode(handler: { [weak self] status in
                guard let `self` = self else {
                    return
                }
                
                self.addStatusCmd(ss: "\(status)")
                
                self.collectionView.reloadData()
            })
        }
        
        if title == .exitPetMode {
            self.addBleCmd(ss: "exitPetMode")
            
            self.XM_Anker?.exitPetMode(handler: { [weak self] status in
                guard let `self` = self else {
                    return
                }
                
                self.addStatusCmd(ss: "\(status)")
                
                self.collectionView.reloadData()
            })
        }
        
        if title == .fetchPregnantWomanMode {
            self.addBleCmd(ss: "fetchPregnantWomanModeStatus")
            
            self.XM_Anker?.fetchPregnantWomanModeStatus(handler: { [weak self] status in
                guard let `self` = self else {
                    return
                }
                
                self.addStatusCmd(ss: "\(status)")
                
                self.collectionView.reloadData()
            })
        }
        
        if title == .switchMode {
            self.addBleCmd(ss: "switchMode")
            
            self.ankerMode = self.ankerMode == .internalCode ? .calibration : .internalCode
            
            self.XM_Anker?.switchMode(self.ankerMode, withHandler: { [weak self] status in
                guard let `self` = self else {
                    return
                }
                
                self.addStatusCmd(ss: "\(status)")
                
                self.collectionView.reloadData()
            })
        }
        
        if title == .restoreFactory {
            self.addBleCmd(ss: "restoreFactory")

            self.XM_Anker?.restoreFactory { [weak self] status in
                guard let `self` = self else {
                    return
                }
                
                self.addStatusCmd(ss: "\(status)")
                
                self.collectionView.reloadData()
            }
        }
        
        if title == .fetchDeviceTime {
            self.addBleCmd(ss: "fetchDeviceTime")

            self.XM_Anker?.fetchDeviceTime{ [weak self] deviceTime in
                guard let `self` = self else {
                    return
                }
                
                self.addStatusCmd(ss: "\(deviceTime)")
                
                self.collectionView.reloadData()
            }
        }
        
        if title == .fetchDeviceTime {
            self.addBleCmd(ss: "fetchDeviceTime")

            self.XM_Anker?.fetchDeviceTime{ [weak self] deviceTime in
                guard let `self` = self else {
                    return
                }
                
                self.addStatusCmd(ss: "\(deviceTime)")
                
                self.collectionView.reloadData()
            }
        }
        
        if title == .syncUserInfo {
            self.addBleCmd(ss: "fetchDeviceTime")
            
            let user = AKUserModel()
            user.userID = "c7498a2f-11d0-4576-a074-bf13b47c92f0"
            user.age = 20
            user.height = 175
            user.weight = 60 * 100
            user.athleteLevel = .normal
            user.gender = .male

            self.XM_Anker?.syncUserInfo(user, withHandler: { [weak self] status in
                guard let `self` = self else {
                    return
                }
                
                self.addStatusCmd(ss: "\(status)")
                
                self.collectionView.reloadData()
            });
        }
        
        if title == .deleteDeviceHistory {
            self.addBleCmd(ss: "deleteDeviceHistory")

            self.XM_Anker?.deleteDeviceHistoryData(handler: { [weak self] status in
                guard let `self` = self else {
                    return
                }
                
                self.addStatusCmd(ss: "\(status)")
                
                self.collectionView.reloadData()
            });
        }
        
        if title == .fetchDeviceBatteryInfo {
            self.addBleCmd(ss: "fetchDeviceBatteryInfo")

            self.XM_Anker?.fetchDeviceBatteryInfo()
        }
        
        if title == .findSurroundWIFI {
            self.addBleCmd(ss: "findSurroundWIFI")

            self.XM_Anker?.findSurroundWIFI({ [weak self] (wifiList, status) in
                guard let `self` = self else {
                    return
                }
                
                for wifi in wifiList {
                    self.addStatusCmd(ss: "\(wifi.ssid)")
                }

                self.collectionView.reloadData()
            });
        }
        
        if title == .distributionNetwork{
            self.addBleCmd(ss: "startWifi")
            self.XM_Anker?.startWifi(handler: { [weak self] status in
                guard let `self` = self else {
                    return
                }
                
                self.addStatusCmd(ss: "\(status)")
            })
        }
    }
}

extension DeviceAnkerViewController:AKBluetoothUpdateStateDelegate{
    func centralManagerDidUpdate(_ state: AKBluetoothState) {
        
        
        self.addConsoleLog(ss: "centralManagerDidUpdate")
        
        self.consoleView.text = self.conslogStr
        
        self.scaleManager.searchSurroundDevice()
    }
    

    
    
    
}

extension DeviceAnkerViewController:AKBluetoothSurroundDeviceDelegate{
    

    
    func centralManagerDidFoundSurroundDevice(_ device: AKBluetoothAdvDeviceModel!, andPeripheral peripheral: CBPeripheral!) {
        
        
        if(device.deviceMac == self.deviceModel.deviceMac){
            
            
            self.addConsoleLog(ss: "centralManagerDidFoundSurroundDevice mac:\(device.deviceMac)")

            
            self.scaleManager.stopSearch()
            
            
            self.scaleManager.connectDelegate = self;
            self.scaleManager.connect(peripheral, withDevice: device)
            
            self.XM_Anker = AKBluetoothPeripheralAnker(peripheral: peripheral, andDevice: device)
            self.XM_Anker?.serviceDelegate = self
            self.XM_Anker?.scaleDataDelegate = self
            
        }
        


    }
    
}

extension DeviceAnkerViewController:AKBluetoothConnectDelegate{
    
    
    func centralManagerDidConnect() {
                
        self.addConsoleLog(ss: "centralManagerDidConnect")
        self.addBleCmd(ss: "discoverFFF0Service")
        
        self.XM_Anker?.discoverFFF0Service()
    }
    
    func centralManagerDidDisconnect() {
        
        self.XM_IsConnect = false
        
        self.connectStateLbl.text = "disconnect"
        
        self.connectStateLbl.textColor = UIColor.red
        
//        guard let peripheral = self.XM_Anker?.peripheral , let XM_DeviceModel = self.deviceModel else{
//            return
//        }
//        
//        self.scaleManager.connect(peripheral, withDevice: XM_DeviceModel)

    }
    
}

extension DeviceAnkerViewController: AKBluetoothServiceDelegate{

    func discoverFFF0ServiceSuccess() {

        self.addStatusCmd(ss: "discoverFFF0ServiceSuccess")
        
        self.XM_IsConnect = true
        self.connectStateLbl.text = "connected"
        self.connectStateLbl.textColor = UIColor.green
        
        self.XM_Anker?.scaleDataDelegate = self
        
        self.addBleCmd(ss: "startAuth")
        
        self.XM_Anker?.startAuth({ [weak self] staus in
            
            guard let `self` = self else {
                return
            }
            
            self.addStatusCmd(ss: "鉴权状态:\(staus)")
        })

    }
    
}

extension DeviceAnkerViewController:AKBluetoothScaleDataDelegate{
    func monitorProcessData(_ model: AKBluetoothScaleBaseModel!, advModel: AKBluetoothAdvDeviceModel!) {
        
        self.weightLbl.text = String.init(format: "weight process:%0.2f", Float(model.weight) / 100.0)
        self.weightLbl.textColor = UIColor.red
        
        self.scaleCoconutViewController?.XM_AKBluetoothScaleBaseModel = model
        self.scaleCoconutViewController?.complete = false
        
//        let ret:[String:Any] = ["weight" : model.weight, "impedance": model.impedance, "type" : model.dataType.rawValue, "fat": model.fat, "heartRate": model.heartRate,"isImpedanceTem": model.isImpedanceTem,"impedanceEnCode": model.impedanceEnCode]
//        print("ret:\(ret)")
        
    }
    
    func monitorLockData(_ model: AKBluetoothScaleBaseModel!, advModel: AKBluetoothAdvDeviceModel!) {
        
        self.weightLbl.text = String.init(format: "weight lock:%0.2f", Float(model.weight) / 100.0)
        self.weightLbl.textColor = UIColor.green
        
        self.scaleCoconutViewController?.XM_AKBluetoothScaleBaseModel = model
        self.scaleCoconutViewController?.complete = true
    }
    
    func monitorBatteryInfoChange(_ model: AKBatteryInfoModel!, advModel: AKBluetoothAdvDeviceModel!) {
        self.addStatusCmd(ss: "monitorBatteryInfoChange:\(model.power)")
        
    }
    
}

extension DeviceAnkerViewController:StoryboardInstantiable{
    static var storyboardName: String {
        return "Main"
    }
    
    static var storyboardIdentifier: String {
        return "DeviceAnkerViewController"
    }
    
    
    
}
