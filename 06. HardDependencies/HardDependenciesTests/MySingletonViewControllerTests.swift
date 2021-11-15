//
//  MySingletonViewControllerTests.swift
//  HardDependenciesTests
//
//  Created by RATAMATE on 08/11/21.
//

import XCTest
@testable import HardDependencies

class MySingletonViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        MySingletonAnalytics.stubbedInstance = MySingletonAnalytics()
    }
    
    override func tearDown() {
        MySingletonAnalytics.stubbedInstance = nil
        super.tearDown()
    }
    
    func test_viewDidAppear(){
        let sut = MySingletonViewController()
        sut.loadViewIfNeeded()
        sut.viewDidAppear(false)
    }
}
