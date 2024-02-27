//
//  CalcuteInfoViewController.swift
//  AnkerBluetoothKitDemo
//
//  Created by  lefu on 2023/7/28.
//

import UIKit

enum calcuteType{
    case calcuteType4AC
}

struct UserModel:Codable{
    
    var sex = 0
    var impedance = 1000
    var weight : Float  = 60
    var age = 20
    var height = 160
    var heartRate:Int = 0

    
    var isAthleteMode  = 0
    
    enum CodingKeys: String, CodingKey {
           case sex, impedance, weight, age, height

        case isAthleteMode
       }
    
    
    // 实现Decodable协议的init(from decoder: Decoder)方法
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sex = try container.decode(Int.self, forKey: .sex)
        impedance = try container.decode(Int.self, forKey: .impedance)
        age = try container.decode(Int.self, forKey: .age)
        height = try container.decode(Int.self, forKey: .height)
        
        // 将weight属性从Double类型解码为CGFloat类型
        weight = try container.decode(Float.self, forKey: .weight)

        isAthleteMode = try container.decode(Int.self, forKey: .isAthleteMode)

        
    }

}

class CalcuteInfoViewController: UIViewController {

    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var impedenceTF: UITextField!
    @IBOutlet weak var weightTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var heightTF: UITextField!
    @IBOutlet weak var heartRateTF: UITextField!
    
    
    var scaleModel:AKBluetoothScaleBaseModel?
    var deviceModel:AKBluetoothAdvDeviceModel?
    
    
    let jsonData = """
        {
            "sex": 0,
             "impedance": 14095389,
             "weight":65,
             "age": 20,
             "height": 160,
            "isAthleteMode":0,
            "heartRate":0,
        }
    """.data(using: .utf8)!
    
    var myUserModel : UserModel!
    var selectCalcuteType = calcuteType.calcuteType4AC

    override func viewDidLoad() {
        super.viewDidLoad()
      
        let decoder = JSONDecoder()
        if let decodedUser = try? decoder.decode(UserModel.self, from: jsonData){
            
            self.myUserModel = decodedUser
        }
        
        self.myUserModel.weight = Float(self.scaleModel?.weight ?? 0) / 100.0
        self.myUserModel.impedance = self.scaleModel?.impedance ?? 0
        self.myUserModel.heartRate = self.scaleModel?.heartRate ?? 0

        if self.myUserModel != nil{
            
            self.ageTF.text = "\(self.myUserModel.age)"
            self.weightTF.text = "\(self.myUserModel.weight)"
            self.heightTF.text = "\(self.myUserModel.height)"
            self.impedenceTF.text = "\(self.myUserModel.impedance)"
            self.genderSegment.selectedSegmentIndex = self.myUserModel.sex
            self.heartRateTF.text = "\(self.myUserModel.heartRate)"

        }
    }
    
    @IBAction func segmentValueChange(_ sender: Any) {
    }
    
    @IBAction func calcuteClick(_ sender: Any) {
        
        self.myUserModel.sex = self.genderSegment.selectedSegmentIndex
        
        if let impedence = self.impedenceTF.text{
            
            self.myUserModel.impedance = Int(impedence) ?? 500
        }

        
        if let weight = self.weightTF.text{
            
            self.myUserModel.weight = Float(weight) ?? 60
        }
        
        if let age = self.ageTF.text{
            
            self.myUserModel.age = Int(age) ?? 20
        }
        
        if let height = self.heightTF.text{
            
            self.myUserModel.height = Int(height) ?? 20
        }
        
        if let heartRate = self.heartRateTF.text{
            
            self.myUserModel.heartRate = Int(heartRate) ?? 20
        }
        
        
        
        let vc = CalcuelateResultViewController.instantiate()
        vc.selectCalcuteType = self.selectCalcuteType
        vc.deviceModel = self.deviceModel
        vc.myUserModel  = self.myUserModel
        
        self.navigationController?.pushViewController(vc, animated: true)
    }


}

extension CalcuteInfoViewController:StoryboardInstantiable{
    static var storyboardName: String {
        return "Main"
    }
    
    static var storyboardIdentifier: String {
        return "CalcuteInfoViewController"
    }
    
    
    
}

