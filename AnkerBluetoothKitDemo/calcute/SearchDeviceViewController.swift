//
//  SearchDeviceViewController.swift
//  AnkerBluetoothKitDemo
//
//  Created by  lefu on 2023/7/29.
//

import UIKit
import AnkerBluetoothKit



class SearchDeviceViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    lazy var scaleManager:AKBluetoothConnectManager = AKBluetoothConnectManager()


    var XM_FoundDeviceArray  =  [(AKBluetoothAdvDeviceModel,CBPeripheral)]()

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.scaleManager.stopSearch()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scaleManager.updateStateDelegate = self;
        self.scaleManager.surroundDeviceDelegate = self;

        
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

extension SearchDeviceViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.XM_FoundDeviceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.XM_FoundDeviceArray[indexPath.row]

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell")!
        
        
        cell.textLabel?.numberOfLines = 0
        
        cell.textLabel?.text = "bleName:\(model.0.deviceName)\nmac:\(model.0.deviceMac)\nRSSI:\(model.0.rssi)"
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let model = self.XM_FoundDeviceArray[indexPath.row]

        if model.0.deviceMac.isEmpty {
            return
        }
        
        let vc = DeviceAnkerViewController.instantiate()
        
        vc.title = model.0.deviceName
        
        vc.deviceModel = model.0
        
        self.navigationController?.pushViewController(vc, animated: true)
   
     
    }
    
    
}


extension SearchDeviceViewController:AKBluetoothUpdateStateDelegate,AKBluetoothSurroundDeviceDelegate{
    
    
    
    func centralManagerDidUpdate(_ state: AKBluetoothState) {
        
        if (state == .poweredOn){
            self.scaleManager.searchSurroundDevice()
        }
    }
    
    func centralManagerDidFoundSurroundDevice(_ device: AKBluetoothAdvDeviceModel!, andPeripheral peripheral: CBPeripheral!) {
        
        if !self.XM_FoundDeviceArray.contains(where: { model in
            
            model.1.name == peripheral.name
        }){
            self.XM_FoundDeviceArray.append((device,peripheral))
            
        }
     
      
        self.tableView.reloadData()

    }
    
}


extension SearchDeviceViewController:StoryboardInstantiable{
    static var storyboardName: String {
        return "Main"
    }
    
    static var storyboardIdentifier: String {
        return "SearchDeviceViewController"
    }
    
    
    
}


