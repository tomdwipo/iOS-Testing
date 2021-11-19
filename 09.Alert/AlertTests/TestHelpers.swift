//
//  TestHelpers.swift
//  AlertTests
//
//  Created by RATAMATE on 09/11/21.
//

import UIKit

func tap(_ button: UIButton) {
    button.sendActions(for: UIControl.Event.touchUpInside)
}
