//
//  WifiConfigViewController.swift
//  PPBluetoothKitDemo
//
//  Created by lefu on 2023/8/10.
//

import UIKit
import AnkerBluetoothKit


class WifiConfigViewController: UIViewController {
    
    @IBOutlet weak var ssidTF: UITextField!
    @IBOutlet weak var pwdTF: UITextField!

    @IBOutlet weak var domainTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var wifiList = [AKWifiInfoModel]()
    
    var configHandle:((_ SSID:String,_ password:String, _ domain:String)->Void)?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.domainTF.text = "appliances-api-qa.eufylife.com"
    }

    

    @IBAction func configClick(_ sender: UIButton) {
        
        self.configHandle?(self.ssidTF.text ?? "", self.pwdTF.text ?? "", self.domainTF.text ?? "")
        
        self.navigationController?.popViewController(animated: true)
    }

}

extension WifiConfigViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.wifiList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = self.wifiList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnkerWifiCell", for: indexPath)
        cell.textLabel?.text = model.ssid
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.wifiList[indexPath.row]
        
        self.ssidTF.text = model.ssid
    }

}



extension WifiConfigViewController:StoryboardInstantiable{
    static var storyboardName: String {
        return "Main"
    }

    static var storyboardIdentifier: String {
        return "WifiConfigViewController"
    }



}

