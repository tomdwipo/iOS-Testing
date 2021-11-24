//
//  main.swift
//  TDD
//
//  Created by RATAMATE on 24/11/21.
//

import UIKit

let appDelegate: AnyClass = NSClassFromString("TestingAppDelegate") ?? AppDelegate.self

UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appDelegate))
