//
//  TestHelpers.swift
//  UserDefaultsTests
//
//  Created by RATAMATE on 10/11/21.
//

import UIKit

func tap(_ button: UIButton) {
    button.sendActions(for: UIControl.Event.touchUpInside)
}
