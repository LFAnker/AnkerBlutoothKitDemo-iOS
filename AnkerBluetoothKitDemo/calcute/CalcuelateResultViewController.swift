//
//  CalcuelateResultViewController.swift
//  AnkerBluetoothKitDemo
//
//  Created by  lefu on 2023/7/28.
//

import UIKit
import AnkerBluetoothKit

class CalcuelateResultViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    var selectCalcuteType = calcuteType.calcuteType4AC
    
    var myUserModel : UserModel!
    var deviceModel:AKBluetoothAdvDeviceModel?

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.showReslut()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
      

        // Do any additional setup after loading the view.
    }
    
    
    func showReslut(){
        let userModel =  AKBluetoothDeviceSettingModel()
        
        userModel.age = self.myUserModel.age
        userModel.height = self.myUserModel.height
        userModel.gender = PPDeviceGenderType.init(rawValue: UInt(self.myUserModel.sex))!
        userModel.isAthleteMode = self.myUserModel.isAthleteMode == 1 ?true:false
        
        let mac = self.deviceModel?.deviceMac ?? "c1:c1:c1:c1"
        let heartRate = self.myUserModel.heartRate
        let impedance = self.myUserModel.impedance
        let weight = CGFloat(self.myUserModel.weight)
        
        var fatModel:AKBodyFatModel!
        
        fatModel =  AKBodyFatModel(userModel: userModel,
                                   deviceCalcuteType: PPDeviceCalcuteType.alternateNormal,
                                   deviceMac: mac,
                                   weight: weight,
                                   heartRate: heartRate,
                                   andImpedance: impedance)
        
        let arr = [ "PP_ERROR_TYPE_NONE",
                    "PP_ERROR_TYPE_AGE" ,
                    "PP_ERROR_TYPE_HEIGHT",
                    "PP_ERROR_TYPE_WEIGHT",
                    "PP_ERROR_TYPE_SEX",
                    "PP_ERROR_TYPE_PEOPLE_TYPE",
                    "PP_ERROR_TYPE_IMPEDANCE_TWO_LEGS",
                    "PP_ERROR_TYPE_IMPEDANCE_TWO_ARMS",
                    "PP_ERROR_TYPE_IMPEDANCE_LEFT_BODY",
                    "PP_ERROR_TYPE_IMPEDANCE_LEFT_ARM",
                    "PP_ERROR_TYPE_IMPEDANCE_RIGHT_ARM",
                    "PP_ERROR_TYPE_IMPEDANCE_LEFT_LEG",
                    "PP_ERROR_TYPE_IMPEDANCE_RIGHT_LEG",
                    "PP_ERROR_TYPE_IMPEDANCE_TRUNK",]
        
        let ss = """
        
        errorType = "\(arr[fatModel.errorType.rawValue])"
        
        ppWeightKgList = \(fatModel.ppWeightKgList)
        ppBMI = \(fatModel.ppBMI)
        ppBMIList = \(fatModel.ppBMIList)
        ppFat = \(fatModel.ppFat)
        ppFatList = \(fatModel.ppFatList)
        ppBodyfatKg = \(fatModel.ppBodyfatKg)
        ppBodyfatKgList = \(fatModel.ppBodyfatKgList)
        ppMusclePercentage = \(fatModel.ppMusclePercentage)
        ppMusclePercentageList = \(fatModel.ppMusclePercentageList)
        ppMuscleKg = \(fatModel.ppMuscleKg)
        ppMuscleKgList = \(fatModel.ppMuscleKgList)
        ppBodySkeletal = \(fatModel.ppBodySkeletal)
        ppBodySkeletalList = \(fatModel.ppBodySkeletalList)
        ppBodySkeletalKg = \(fatModel.ppBodySkeletalKg)
        ppBodySkeletalKgList = \(fatModel.ppBodySkeletalKgList)
        ppWaterPercentage = \(fatModel.ppWaterPercentage)
        ppWaterPercentageList = \(fatModel.ppWaterPercentageList)
        ppWaterKg = \(fatModel.ppWaterKg)
        ppWaterKgList = \(fatModel.ppWaterKgList)
        ppProteinPercentage = \(fatModel.ppProteinPercentage)
        ppProteinPercentageList = \(fatModel.ppProteinPercentageList)
        ppProteinKg = \(fatModel.ppProteinKg)
        ppProteinKgList = \(fatModel.ppProteinKgList)
        ppLoseFatWeightKg = \(fatModel.ppLoseFatWeightKg)
        ppLoseFatWeightKgList = \(fatModel.ppLoseFatWeightKgList)
        ppBodyFatSubCutPercentage = \(fatModel.ppBodyFatSubCutPercentage)
        ppBodyFatSubCutPercentageList = \(fatModel.ppBodyFatSubCutPercentageList)
        ppBodyFatSubCutKg = \(fatModel.ppBodyFatSubCutKg)
        ppBodyFatSubCutKgList = \(fatModel.ppBodyFatSubCutKgList)
        ppHeartRate = \(fatModel.ppHeartRate)
        ppHeartRateList = \(fatModel.ppHeartRateList)
        ppBMR = \(fatModel.ppBMR)
        ppBMRList = \(fatModel.ppBMRList)
        ppVisceralFat = \(fatModel.ppVisceralFat)
        ppVisceralFatList = \(fatModel.ppVisceralFatList)
        ppBoneKg = \(fatModel.ppBoneKg)
        ppBoneKgList = \(fatModel.ppBoneKgList)
        ppBodyMuscleControl = \(fatModel.ppBodyMuscleControl)
        ppFatControlKg = \(fatModel.ppFatControlKg)
        ppBodyStandardWeightKg = \(fatModel.ppBodyStandardWeightKg)
        ppControlWeightKg = \(fatModel.ppControlWeightKg)
        ppBodyType = \(fatModel.ppBodyType.rawValue)
        ppFatGrade = \(fatModel.ppFatGrade.rawValue)
        ppBodyHealth = \(fatModel.ppBodyHealth.rawValue)
        ppBodyAge = \(fatModel.ppBodyAge)
        ppBodyAgeList = \(fatModel.ppBodyAgeList)
        ppBodyScore = \(fatModel.ppBodyScore)
        ppBodyScoreList = \(fatModel.ppBodyScoreList)

        
        """
        
        
        
        self.textView.text = ss
     
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CalcuelateResultViewController:StoryboardInstantiable{
    static var storyboardName: String {
        return "Main"
    }
    
    static var storyboardIdentifier: String {
        return "CalcuelateResultViewController"
    }
    
    
    
}

