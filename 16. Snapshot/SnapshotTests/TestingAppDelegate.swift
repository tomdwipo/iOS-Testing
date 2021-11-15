//
//  TestingAppDelegate.swift
//  SnapshotTests
//
//  Created by RATAMATE on 15/11/21.
//

import UIKit

@objc(TestingAppDelegate)
class TestingAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("Launch from TestingAppDelegate")
        return true
    }

}
