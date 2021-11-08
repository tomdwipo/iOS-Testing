//
//  CodeBasedViewControllerTests.swift
//  LoadViewControllersTests
//
//  Created by RATAMATE on 08/11/21.
//

import XCTest
@testable import LoadViewControllers

class CodeBasedViewControllerTests: XCTestCase {
    func test_loading(){
        let sut = CodeBasedViewController(data: "DUMMY")
        sut.loadViewIfNeeded()
    }

}
