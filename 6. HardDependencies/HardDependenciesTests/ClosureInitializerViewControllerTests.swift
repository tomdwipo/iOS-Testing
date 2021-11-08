//
//  ClosureInitializerViewControllerTests.swift
//  HardDependenciesTests
//
//  Created by RATAMATE on 08/11/21.
//

import XCTest
@testable import HardDependencies

class ClosureInitializerViewControllerTests: XCTestCase {
    
    func test_viewDidAppear(){
        let sut = ClosureInitializerViewController(makeAnalytics: { Analytics() } )
        sut.loadViewIfNeeded()
        sut.viewDidAppear(false)
        
    }

}
