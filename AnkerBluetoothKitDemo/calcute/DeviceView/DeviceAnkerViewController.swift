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
    case distributionNetwork = "distribution network"

    case openHeartRate = "Open HeartRate"
    case closeHeartRate = "Close HeartRate"
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
    
    var code:String?
    var certificateStr:String = """
-----BEGIN CERTIFICATE-----
MIIEADCCAuigAwIBAgIBADANBgkqhkiG9w0BAQUFADBjMQswCQYDVQQGEwJVUzEh
MB8GA1UEChMYVGhlIEdvIERhZGR5IEdyb3VwLCBJbmMuMTEwLwYDVQQLEyhHbyBE
YWRkeSBDbGFzcyAyIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTA0MDYyOTE3
MDYyMFoXDTM0MDYyOTE3MDYyMFowYzELMAkGA1UEBhMCVVMxITAfBgNVBAoTGFRo
ZSBHbyBEYWRkeSBHcm91cCwgSW5jLjExMC8GA1UECxMoR28gRGFkZHkgQ2xhc3Mg
MiBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTCCASAwDQYJKoZIhvcNAQEBBQADggEN
ADCCAQgCggEBAN6d1+pXGEmhW+vXX0iG6r7d/+TvZxz0ZWizV3GgXne77ZtJ6XCA
PVYYYwhv2vLM0D9/AlQiVBDYsoHUwHU9S3/Hd8M+eKsaA7Ugay9qK7HFiH7Eux6w
wdhFJ2+qN1j3hybX2C32qRe3H3I2TqYXP2WYktsqbl2i/ojgC95/5Y0V4evLOtXi
EqITLdiOr18SPaAIBQi2XKVlOARFmR6jYGB0xUGlcmIbYsUfb18aQr4CUWWoriMY
avx4A6lNf4DD+qta/KFApMoZFv6yyO9ecw3ud72a9nmYvLEHZ6IVDd2gWMZEewo+
YihfukEHU1jPEX44dMX4/7VpkI+EdOqXG68CAQOjgcAwgb0wHQYDVR0OBBYEFNLE
sNKR1EwRcbNhyz2h/t2oatTjMIGNBgNVHSMEgYUwgYKAFNLEsNKR1EwRcbNhyz2h
/t2oatTjoWekZTBjMQswCQYDVQQGEwJVUzEhMB8GA1UEChMYVGhlIEdvIERhZGR5
IEdyb3VwLCBJbmMuMTEwLwYDVQQLEyhHbyBEYWRkeSBDbGFzcyAyIENlcnRpZmlj
YXRpb24gQXV0aG9yaXR5ggEAMAwGA1UdEwQFMAMBAf8wDQYJKoZIhvcNAQEFBQAD
ggEBADJL87LKPpH8EsahB4yOd6AzBhRckB4Y9wimPQoZ+YeAEW5p5JYXMP80kWNy
OO7MHAGjHZQopDH2esRU1/blMVgDoszOYtuURXO1v0XJJLXVggKtI3lpjbi2Tc7P
TMozI+gciKqdi0FuFskg5YmezTvacPd+mSYgFFQlq25zheabIZ0KbIIOqPjCDPoQ
HmyW74cNxA9hi63ugyuV+I6ShHI56yDqg+2DzZduCLzrTia2cyvk0/ZM/iZx4mER
dEr/VxqHD3VILs9RaRegAhJhldXRQLIQTO7ErBBDpqWeCtWVYpoNz4iCxTIM5Cuf
ReYNnyicsbkqWletNw+vHX/bvZ8=
-----END CERTIFICATE-----
"""
    var ssidStr:String = ""
    var passwordStr:String = ""
    var domainStr:String = ""
    
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
    
    func displayScaleModel(_ scaleModel:AKBluetoothScaleBaseModel, isLock:Bool) {
        
        let calculateWeightKg = Float(scaleModel.weight)/100
        
        var weightStr = calculateWeightKg.toCurrentUserString(accuracyType: Int(2), unitType: Int(scaleModel.unit.rawValue),forWeight: true) + " \(Int(scaleModel.unit.rawValue).getUnitStr())"
        
        weightStr = isLock ? "weight lock:" + weightStr : "weight process:" + weightStr
        
        if (scaleModel.isHeartRating) {
            
            weightStr = weightStr + "\nMeasuring heart rate..."
        } else if (scaleModel.isFatting) {
            
            weightStr = weightStr + "\nMeasuring body fat..."
        }
        
        self.weightLbl.text = weightStr
        
        
        if isLock {
            
            self.gotoCalcute(scaleModel:scaleModel)
            
        }
        
    }
    
    func gotoCalcute(scaleModel:AKBluetoothScaleBaseModel) {
        
        let alertController = UIAlertController(title: "Go to Calculate Body Data?", message: "", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "ok", style: .default) { (action) in
            
            
            let vc = CalcuteInfoViewController.instantiate()
            vc.scaleModel = scaleModel
            vc.deviceModel = self.deviceModel
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        
        present(alertController, animated: true, completion: nil)
    }

    
    func postRequest(urlStr:String, params:[String: Any], completion:@escaping (Bool, [String:Any]?)->Void) {

        guard let url = URL(string: urlStr) else {
            print("Invalid URL")
            return
        }
        
        let requestBody = params
        
        
        let uuid = UUID().uuidString
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(uuid, forHTTPHeaderField: "terminalId")

        
        do {
            
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch {
            print("Error encoding request body: \(error)")
            return
        }

        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                
                completion(false, nil)
                
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            
            do {

                let respStr = String(data: data, encoding: .utf8)
                print("resp:\(respStr ?? "")")
                
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    
                    completion(false, nil)

                    print("Error decoding response body: Invalid JSON")
                    
                    return
                }
                
                let res_code = json["res_code"] as? Int
                let success = res_code == 1
                
                completion(success, json)
                
            } catch {
                
                completion(false, nil)
                
                print("Error decoding response body: \(error)")
            }
        }
        
        task.resume()
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
        
        return CGSizeMake((UIScreen.main.bounds.size.width - 40) / 3, 50)
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
            self.addBleCmd(ss: "syncUserInfo")
            
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
            
            self.addBleCmd(ss: "findSurroundWIFI")
            self.addConsoleLog(ss: "hold on...")
            self.XM_Anker?.findSurroundWIFI({ [weak self] (wifiList, status) in
                guard let `self` = self else {
                    return
                }
                
                let vc = WifiConfigViewController.instantiate()
                vc.wifiList = wifiList
                
                vc.configHandle = { [weak self] (ssid, password, domain) in
                    
                    guard let `self` = self else {
                        return
                    }
                    
                    self.addStatusCmd(ss: "ssid:\(ssid)")
                    self.addStatusCmd(ss: "password:\(password)")
                    self.addStatusCmd(ss: "domain:\(domain)")
                    
                    if ssid.count > 0 && password.count > 0 && domain.count > 0 {
                        self.ssidStr = ssid
                        self.passwordStr = password
                        self.domainStr = domain
                        
                        self.requestCode { [weak self] success in
                            guard let `self` = self else { return }
                            
                            if success {
                                
                                self.startWifi()
                                
                            }
                        }
                    }
                }
                
                self.navigationController?.pushViewController(vc, animated: true)
            });

        }
    }
    
    // Wi-Fi:step 1
    // start wifi
    func startWifi() {
        if !self.XM_IsConnect{
            
            self.addStatusCmd(ss: "device disconnect")
            return
        }
        
        self.addBleCmd(ss: "startWifi")
        
        self.XM_Anker?.startWifi(handler: { [weak self] status in
            guard let `self` = self else { return }
            
            self.addStatusCmd(ss: "\(status)")
            
            if status == 0 {
                
                self.sendCodeUidDomain()
            }
        })
        
    }
    
    // Wi-Fi:step 2
    // send code、uid、domain
    func sendCodeUidDomain() {
        guard let code = self.code else {
            self.addStatusCmd(ss: "empty code")
            return
        }
        
        let uid = "3bd08f9a7350c51b431daf1ebd3fc180806cf84b"
        let domain = self.domainStr
        
        self.addBleCmd(ss: "sendWifiCode")
        self.addConsoleLog(ss: "hold on...")
        
        print("code:\(code) uid:\(uid) domain:\(domain)")
        
        self.XM_Anker?.sendWifiCode(code, uid: uid, domain: domain, handler: { [weak self] status in
            guard let `self` = self else { return }
            
            self.addStatusCmd(ss: "\(status)")
            
            if status == 0 {
                
                self.sendCertificate()
                
            }
        })
        
    }
    
    // Wi-Fi:step 3
    // send certificate
    func sendCertificate() {
        self.addBleCmd(ss: "sendCertificate")
        
        let cerStr = self.certificateStr
        print("certificateStr:\(cerStr)")
        print("certificateStrlen:\(cerStr.count)")
        self.XM_Anker?.sendCertificate(cerStr, withHandler: { [weak self] status in
            guard let `self` = self else { return }
            
            self.addStatusCmd(ss: "\(status)")
            
            if status == 0 {
                
                self.sendCertificateComplete()
            }
        })
    }
    
    // Wi-Fi:step 4
    // Send certificate completed
    func sendCertificateComplete() {
        
        self.addBleCmd(ss: "sendCertificateComplete")
        self.XM_Anker?.sendCertificateComplete(handler: { [weak self] status in
            guard let `self` = self else { return }
            
            self.addStatusCmd(ss: "\(status)")
            
            if status == 0 {
                
                self.updateWifiSSID()
            }
        })
    }
    
    // Wi-Fi:step 5
    // update Wifi SSID
    func updateWifiSSID() {
        
        self.addBleCmd(ss: "updateWifiSSID")
        
        let ssid = self.ssidStr
        self.XM_Anker?.updateWifiSSID(ssid, withHandler: { [weak self] status in
            guard let `self` = self else { return }
            
            self.addStatusCmd(ss: "\(status)")
            
            if status == 0 {
                
                self.updateWifiPassword()
            }
        })
    }
    
    // Wi-Fi:step 6
    // update Wifi Password
    func updateWifiPassword() {
        
        self.addBleCmd(ss: "updateWifiPassword")
        
        let password = self.passwordStr
        self.XM_Anker?.updateWifiPassword(password, withHandler: { [weak self] status in
            guard let `self` = self else { return }
            
            self.addStatusCmd(ss: "\(status)")
            
            if status == 0 {
                
                self.updateWifiParametersComplete()
            }
        })
    }
    
    // Wi-Fi:step 7
    // updating Wi-Fi parameters completed
    func updateWifiParametersComplete() {
        
        self.addBleCmd(ss: "updateWifiInfoComplete")

        self.XM_Anker?.updateWifiInfoComplete(handler: { [weak self] (status, step, errorType, errorCode) in
            guard let `self` = self else { return }
            
            self.addStatusCmd(ss: "\(status) step:\(step) errorType:\(errorType.rawValue) errorCode:\(errorCode)")

            if status == 0 { // success
                self.addStatusCmd(ss: "Successful distribution network")
            } else {
                self.addStatusCmd(ss: "Distribution network failure")
            }
            
        })
    }
    
    
    func requestCode(handler:@escaping (Bool)->Void) {
        
        var parameters : [String : String] = [:]
        parameters["client_id"] = "wifi_scale"
        parameters["client_secret"] = "ICXQIBAAKBgQCcoakXBN"
        parameters["code"] = "wifi_scale"

        self.addBleCmd(ss: "Requesting code from the server")
        self.postRequest(urlStr: "https://api.eufylife.com/v1/user/wifi_scale/bind_code", params: parameters) { [weak self] success, dataDict in
            
            guard let `self` = self else {
                return
            }
            
            DispatchQueue.main.async {
                if success == true, let code = dataDict?["code"] as? String {
                    
                    self.addStatusCmd(ss: "Request success code:\(code)")
                    self.code = code

                    handler(true)
                } else {
                    
                    self.addStatusCmd(ss: "Request error:\(dataDict?["message"] ?? "")")
                    
                    handler(false)
                }
            }

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
        
        self.displayScaleModel(model, isLock: false)
        self.weightLbl.textColor = UIColor.red
        
        self.scaleCoconutViewController?.XM_AKBluetoothScaleBaseModel = model
        self.scaleCoconutViewController?.complete = false
        
    }
    
    func monitorLockData(_ model: AKBluetoothScaleBaseModel!, advModel: AKBluetoothAdvDeviceModel!) {
        
        self.displayScaleModel(model, isLock: true)
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
