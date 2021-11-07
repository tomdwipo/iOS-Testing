//
//  AppDelegate.swift
//  LoadViewControllers
//
//  Created by RATAMATE on 07/11/21.
//

import UIKit


class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("from AppDelegate")
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
}

