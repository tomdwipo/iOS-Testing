//
//  TestHelpers.swift
//  ButtonTapTests
//
//  Created by RATAMATE on 09/11/21.
//

import Foundation
import UIKit

func tap(_ button: UIButton) {
    button.sendActions(for: UIControl.Event.touchUpInside)
}

func tap(_ button: UIBarButtonItem) {
    _ = button.target?.perform(button.action, with: nil)
}

