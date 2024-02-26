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
    
    

    
    
    let jsonData = """
        {
            "sex": 0,
             "impedance": 14095389,
             "weight":65,
             "age": 20,
             "height": 160,
            "isAthleteMode":0,
        }
    """.data(using: .utf8)!
    
    var myUserModel : UserModel!
    var selectCalcuteType = calcuteType.calcuteType4AC
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let data = UserDefaults.standard.data(forKey: "userInfo"){
            
            let decoder = JSONDecoder()
            if let decodedUser = try? decoder.decode(UserModel.self, from: data){
                
                self.myUserModel = decodedUser
            }
        }else{
            
            
            let decoder = JSONDecoder()
            if let decodedUser = try? decoder.decode(UserModel.self, from: jsonData){
                
                self.myUserModel = decodedUser
            }
            
        }
        

        
        if self.myUserModel != nil{
            self.ageTF.text = "\(self.myUserModel.age)"
            
            self.weightTF.text = "\(self.myUserModel.weight)"
            self.heightTF.text = "\(self.myUserModel.height)"
            self.impedenceTF.text = "\(self.myUserModel.impedance)"
            self.genderSegment.selectedSegmentIndex = self.myUserModel.sex
            
            
     
            
           


        }
        
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
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
        

       
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let jsonData = try? encoder.encode(self.myUserModel){
            
            UserDefaults.standard.set(jsonData, forKey: "userInfo")
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      

        // Do any additional setup after loading the view.
    }
    
    @IBAction func segmentValueChange(_ sender: Any) {
    }
    
    @IBAction func calcuteClick(_ sender: Any) {
        
        let vc = CalcuelateResultViewController.instantiate()
        vc.selectCalcuteType = self.selectCalcuteType
        
        self.navigationController?.pushViewController(vc, animated: true)
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

extension CalcuteInfoViewController:StoryboardInstantiable{
    static var storyboardName: String {
        return "Main"
    }
    
    static var storyboardIdentifier: String {
        return "CalcuteInfoViewController"
    }
    
    
    
}

