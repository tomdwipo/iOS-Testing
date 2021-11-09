//
//  TestHelper.swift
//  NavigationTests
//
//  Created by RATAMATE on 09/11/21.
//

import UIKit


func tap(_ button: UIButton) {
    button.sendActions(for: UIControl.Event.touchUpInside)
}

func executeRunLoop(){
    RunLoop.current.run(until: Date())
}
