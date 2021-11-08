//
//  InstancePropertyViewControllerTests.swift
//  HardDependenciesTests
//
//  Created by RATAMATE on 08/11/21.
//

import XCTest
@testable import HardDependencies

class InstancePropertyViewControllerTests: XCTestCase {

    func test_zero(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut: InstancePropertyViewController = storyboard.instantiateViewController(withIdentifier: String(describing: InstancePropertyViewController.self)) as! InstancePropertyViewController
        sut.analytics = Analytics()
        sut.loadViewIfNeeded()
        sut.viewDidAppear(false)
    }
}
