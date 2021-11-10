//
//  TestHelper.swift
//  NavigationTests
//
//  Created by RATAMATE on 09/11/21.
//

import UIKit
import XCTest


func tap(_ button: UIButton) {
    button.sendActions(for: UIControl.Event.touchUpInside)
}

func executeRunLoop(){
    RunLoop.current.run(until: Date())
}

func putInWindow(_ vc: UIViewController){
    let window = UIWindow()
    window.rootViewController = vc
    window.isHidden = false
}
