//
//  TestingAppDelegate.swift
//  TDDTests
//
//  Created by RATAMATE on 24/11/21.
//

import UIKit
@testable import TDD

@objc(TestingAppDelegate)
class TestingAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       print(">> Launch from TestingAppDelegate")
        return true
    }
}
