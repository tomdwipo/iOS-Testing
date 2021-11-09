//
//  ViewControllerTests.swift
//  ButtonTapTests
//
//  Created by RATAMATE on 09/11/21.
//

import XCTest
@testable import ButtonTap
import UIKit

class ViewControllerTests: XCTestCase {

    func test_tappingButton(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as! ViewController
        sut.loadViewIfNeeded()
        sut.button.sendActions(for: UIControl.Event.touchUpInside)
    }

}
