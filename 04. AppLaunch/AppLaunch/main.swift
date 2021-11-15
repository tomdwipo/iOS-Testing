//
//  Main.swift
//  AppLaunch
//
//  Created by RATAMATE on 07/11/21.
//

import UIKit

let appDelegateClass: AnyClass = NSClassFromString("TestingAppDelegate") ?? AppDelegate.self

UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appDelegateClass))
