//
//  StoryboradBasedViewControllerTests.swift
//  LoadViewControllersTests
//
//  Created by RATAMATE on 07/11/21.
//

import XCTest

@testable import LoadViewControllers

class StoryboradBasedViewControllerTests: XCTestCase {
    func test_loading() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let sut = sb.instantiateViewController(withIdentifier: String(describing: StoryboardBasedViewController.self)) as! StoryboardBasedViewController
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.label)
    }
}
