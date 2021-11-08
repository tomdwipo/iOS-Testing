//
//  OverrideViewControllerTests.swift
//  HardDependenciesTests
//
//  Created by RATAMATE on 08/11/21.
//

import XCTest
@testable import HardDependencies

private class TestableOverrideViewController: OverrideViewController {
    override func analytics() -> Analytics {
        Analytics()
    }
}

class OverrideViewControllerTests: XCTestCase {
   
    func test_viewDidAppear(){
        
        let sut = TestableOverrideViewController()
        sut.loadViewIfNeeded()
        sut.viewDidAppear(false)
    }
}
