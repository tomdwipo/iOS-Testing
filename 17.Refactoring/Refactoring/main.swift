//
//  main.swift
//  Refactoring
//
//  Created by RATAMATE on 15/11/21.
//

import UIKit

let appDelegate: AnyClass = NSClassFromString("TestingAppDelegate") ?? AppDelegate.self

UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appDelegate))
