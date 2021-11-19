//
//  ClosurePropertyViewControllerTests.swift
//  HardDependenciesTests
//
//  Created by RATAMATE on 08/11/21.
//

import XCTest
@testable import HardDependencies

class ClosurePropertyViewControllerTests: XCTestCase {
    
    func test_viewDidAppear(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut: ClosurePropertyViewController = storyboard.instantiateViewController(withIdentifier: String(describing: ClosurePropertyViewController.self)) as! ClosurePropertyViewController
        sut.makeAnalytics = { Analytics() }
        sut.loadViewIfNeeded()
        sut.viewDidAppear(false)
    }
}
