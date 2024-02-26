//
//  AppDelegate.swift
//  AnkerBluetoothKitDemo
//
//  Created by  lefu on 2023/6/3.
//

import UIKit
import AnkerBluetoothKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        let userDefaults = UserDefaults.standard


        
        if userDefaults.object(forKey: "userModel.shared") == nil{
            
            let data = try! NSKeyedArchiver.archivedData(withRootObject: userModel.shared, requiringSecureCoding: false)
            userDefaults.set(data, forKey: "userModel.shared")
            userDefaults.synchronize()
        }else{
            if let data = userDefaults.data(forKey: "userModel.shared") {
                let person = try! NSKeyedUnarchiver.unarchiveObject(with: data) as! userModel
                userModel.shared.sex = person.sex
                userModel.shared.height = person.height
                userModel.shared.age = person.age
                userModel.shared.isAthleteMode = person.isAthleteMode
                userModel.shared.isPregnantMode = person.isPregnantMode

            }
        }
        
        
        // Override point for customization after application launch.
        
//        window = UIWindow(frame: UIScreen.main.bounds)
//
//
//
//
//        window?.rootViewController = UIViewController()
//
//        window?.makeKeyAndVisible()
        
        return true
    }

 
}

protocol StoryboardInstantiable {

    static var storyboardName: String { get }
    static var storyboardIdentifier: String { get }
}
extension StoryboardInstantiable {

  
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)

        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
    
}


