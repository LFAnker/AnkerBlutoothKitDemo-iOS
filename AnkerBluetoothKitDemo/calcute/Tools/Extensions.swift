//
//  Extensions.swift
//  AnkerBluetoothKitDemo
//
//  Created by lefu on 2023/12/1
//  


import Foundation

extension Int{
    func toFoodUnitStr(deviceAccuracyType:PPDeviceAccuracyType, unit: PPDeviceUnit, deviceName:String, isPlus:Bool) -> (String, String){
        let dic = AKUnitTool.weightStrNew(with: CGFloat(self), accuracyType: deviceAccuracyType, andUnit: unit, deviceName: deviceName)
        var weightStr = ""
        if unit == PPDeviceUnit.unitLBOZ {
            weightStr = "\(isPlus ? "":"-")\(dic["lboz_lb"] ?? ""):\(dic["lboz_oz"] ?? "")"
        } else {
            weightStr = "\(isPlus ? "":"-")\(dic["weight"] ?? "")"
            if dic["weight"] as? Float == 0{
                weightStr = "0"
            }
        }
        var unitStr = "g"
        if (unit == PPDeviceUnit.unitG) {
            unitStr = "g"
        }else if(unit == PPDeviceUnit.unitOZ){
            unitStr = "oz"

        }else if(unit == PPDeviceUnit.unitMLMilk){

            unitStr = "ml(milk)"
        }else if(unit == PPDeviceUnit.unitMLWater){
            
            unitStr = "ml(water)"
        }else if(unit == PPDeviceUnit.unitFLOZWater){
            
            unitStr = "fl.oz(water)"
        }else if(unit == PPDeviceUnit.unitFLOZMilk){
            
            unitStr = "fl.oz(milk)"
        }else if(unit == PPDeviceUnit.unitLBOZ){
            
            unitStr = "lb:oz"
        }else if(unit == PPDeviceUnit.unitLB){
            
            unitStr = "lb"
        }
        return (weightStr, unitStr)
    }
}
