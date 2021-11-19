//
//  TestingAppDelegate.swift
//  TableViewTests
//
//  Created by RATAMATE on 14/11/21.
//

import Foundation

import UIKit

@objc(TestingAppDelegate)
class TestingAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("Launch from TestingAppDelegate")
        return true
    }
}
