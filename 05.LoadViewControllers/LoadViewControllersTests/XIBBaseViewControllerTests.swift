//
//  XIBBaseViewControllerTests.swift
//  LoadViewControllersTests
//
//  Created by RATAMATE on 08/11/21.
//

import XCTest
@testable import LoadViewControllers

class XIBBaseViewControllerTests: XCTestCase {

    func test_loading(){
        let sut = XIBBasedViewController()
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.label)
    }

}
