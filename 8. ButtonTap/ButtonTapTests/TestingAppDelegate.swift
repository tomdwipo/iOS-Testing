//
//  TestingAppDelegate.swift
//  ButtonTapTests
//
//  Created by RATAMATE on 09/11/21.
//

import UIKit

@objc(TestingAppDelegate)
class TestingAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("Launch from TestingAppDelegate")
        return true
    }

}
