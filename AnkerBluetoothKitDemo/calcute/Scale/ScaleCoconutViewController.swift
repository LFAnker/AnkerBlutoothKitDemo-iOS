//
//  ScaleCoconutViewController.swift
//  AnkerBluetoothKitDemo
//
//  Created by 杨青山 on 2023/8/9.
//

import UIKit



class ScaleCoconutViewController:UIViewController{

    @IBOutlet weak var weightLabe: UILabel!
    
    @IBOutlet weak var consoleTextView: UITextView!
    
    var deviceModel : AKBluetoothAdvDeviceModel!
    
    var complete :Bool?{
        didSet{
            guard let com = complete else {
                return;
            }
            DispatchQueue.main.async {
                if (com == true) {
                    self.weightLabe.textColor = UIColor.green

                } else {
                    self.weightLabe.textColor = UIColor.red

                }

            }
        }
    }
    
    var conslogStr = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        

    }

    var XM_AKBluetoothScaleBaseModel :AKBluetoothScaleBaseModel? {
        
        didSet {
            
            guard let model = XM_AKBluetoothScaleBaseModel else{
                
        
                return
            }
            DispatchQueue.main.async {
                self.weightLabe.text = String.init(format: "weight lock:%0.2f", Float(model.weight) / 100.0)
                
                if model.heartRate > 0{
                    
                    self.weightLabe.text = String.init(format: "weight lock:%0.2f    heartRate:%ld", Float(model.weight) / 100.0,model.heartRate)

                }
                
                if let com = self.complete{
                 
                    if com{
                        self.addConsoleLog(ss: "monitorLockData")

                    }else{
                        self.addConsoleLog(ss: "monitorProcessData")

                    }
                }
                
                
                self.addStatusCmd(ss: model.description)
            }

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}




extension ScaleCoconutViewController:StoryboardInstantiable{
    static var storyboardName: String {
        return "Main"
    }
    static var storyboardIdentifier: String {
        return "ScaleCoconutViewController"
    }
}

extension ScaleCoconutViewController{
    
     func addConsoleLog(ss:String){
         self.conslogStr.append("\ndelegate:\(ss)\n")
         
       
         self.scrollBottom()
    }
    
    func addBleCmd(ss:String){
        self.conslogStr.append("\nfunction:\(ss)\n")

        self.scrollBottom()

    }
    
    
    func addStatusCmd(ss:String){
        self.conslogStr.append("\nstatus:\(ss)\n")

        self.scrollBottom()

    }
    
    func scrollBottom(){
        self.consoleTextView.text = self.conslogStr
        
        let bottomOffset = CGPoint(x: 0, y: consoleTextView.contentSize.height - consoleTextView.bounds.size.height)
          if bottomOffset.y > 0 {
              consoleTextView.setContentOffset(bottomOffset, animated: true)
          }
    }
}
