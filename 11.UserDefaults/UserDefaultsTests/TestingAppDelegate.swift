//
//  TestingAppDelegate.swift
//  UserDefaultsTests
//
//  Created by RATAMATE on 10/11/21.
//

import UIKit

@objc(TestingAppDelegate)
class TestingAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(">> launch from TestingAppDelegate")
        return true
    }
}
