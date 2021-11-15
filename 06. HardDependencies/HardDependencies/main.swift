//
//  main.swift
//  HardDependencies
//
//  Created by RATAMATE on 08/11/21.
//

import Foundation
import UIKit

let appDelegate: AnyClass = NSClassFromString("TestingAppDelegate") ?? AppDelegate.self

UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appDelegate))
