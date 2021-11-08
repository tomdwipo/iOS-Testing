//
//  InstanceInitializerViewControllerTests.swift
//  HardDependenciesTests
//
//  Created by RATAMATE on 08/11/21.
//

import XCTest
@testable import HardDependencies

class InstanceInitializerViewControllerTests: XCTestCase {
   
    func test_viewDidAppear(){
        let sut = InstanceInitializerViewController(analytics: Analytics())
        sut.loadViewIfNeeded()
        sut.viewDidAppear(false)
    }
}
